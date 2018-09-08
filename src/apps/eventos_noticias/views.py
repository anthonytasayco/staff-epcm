# -*- coding: utf-8 -*-
from logging import getLogger
# import json
from django.http import Http404

from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.template import RequestContext as ctx
from django.core.cache import cache
from django.views.decorators.cache import cache_page
from django.http import JsonResponse
from django.conf import settings
# from uuslug import uuslug
from datetime import date
from django.template.defaultfilters import safe, slugify, date as dt_tmpl, striptags

from django.views.decorators.csrf import csrf_exempt
from ratelimit.decorators import ratelimit
# from .templatetags import app_tags

from ..core.util.util import TextTemplateView,chunks

from models import (HomeEventosSeccion,EventosSociales,HomeNoticiasSeccion,Noticias)
from .util import get_info, get_coors
from ..web.models import Blog

from django.utils import translation
from django.utils.translation import ugettext as _

from django.core.urlresolvers import reverse, resolve

log = getLogger('django')


def eventos(request):
	log.info('VIEW: home')
	info = get_info()
	request.wHead = 'eventos'
	last_page = request.GET.get('p',1)
	eventos_all = EventosSociales.objects.active().order_by('-fecha')[:365]
	if request.method == 'POST':
		if request.POST.get('page',False):
			eventos = wPagin(last_page,eventos_all,9)
			response = []
			for row in eventos:
				response.append({
						"name":row.nombre,
						"img":row.img.url,
						"link":reverse('notivent:evento', kwargs={'slug':row.slug}),
					})
			return JsonResponse({'items':response}, safe=True)

	eventos = wPagin(last_page,eventos_all,9)
	seccion, created = HomeEventosSeccion.objects.get_or_create(pk=1)
	other, created = HomeNoticiasSeccion.objects.get_or_create(pk=1)

	# eventos = EventosSociales.objects.active().filter(fecha__gte=date.today())
	return render('web/eventos.html', locals(), context_instance=ctx(request))

def evento(request, slug=False):
	log.info('VIEW: home')
	info = get_info()
	request.wHead = 'eventos'
	evento = get_object_or_404(EventosSociales,slug=slug)
	# evento = get_object_or_404(EventosSociales,slug=slug)
	# if evento.fecha <= date.today():
	# 	e_past = True
	# 	others = EventosSociales.objects.active().filter(fecha__lte=evento.fecha)[:3]
	# else:
	# 	e_past = False
	return render('web/evento-detalle.html', locals(), context_instance=ctx(request))


def noticias(request):
	log.info('VIEW: home')
	info = get_info()
	request.wHead = 'noticias'
	last_page = request.GET.get('p',1)
	noticias_all = Boticias.objects.order_by('-createdat')
	noticias = wPagin(last_page,noticias_all,9)
	if request.method == 'POST':
		if request.POST.get('page',False):
			# noticias = wPagin(last_page,noticias_all,9)
			response = []
			for row in noticias:
				response.append({
						"postid": row.postid,
            					"imagen": row.imagen,
            					"title": row.title,
            					"excerpt": row.excerpt,
            					"link": row.link,
            					"createdat": row.createdat,
						#"id":row.pk,
						#"name":row.nombre,
						#"img":row.img.url,
						#"fecha":dt_tmpl(row.fecha,"d N Y"),
						#"descript":striptags(safe(row.descript)),
						#"link":reverse('notivent:noticia', kwargs={'slug':row.slug}),
					})
			return JsonResponse({'items':response}, safe=True)

	seccion, created = HomeNoticiasSeccion.objects.get_or_create(pk=1)
	other, created = HomeEventosSeccion.objects.get_or_create(pk=1)
	# noticias = Noticias.objects.active().order_by('-fecha')
	return render('web/noticias.html', locals(), context_instance=ctx(request))


def noticia(request, slug=False):
	log.info('VIEW: home')
	info = get_info()
	request.wHead = 'noticias'
	noticia = get_object_or_404(Noticias,slug=slug)
	return render('web/noticia-detalle.html', locals(), context_instance=ctx(request))


def wPagin(page,obj,num_per_page):
	paginator = Paginator(obj, num_per_page)
	try:
		obj = paginator.page(page)
	except PageNotAnInteger:
		raise Http404
	except EmptyPage:
		raise Http404
	return obj
