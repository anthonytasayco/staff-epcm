# -*- coding: utf-8 -*-
from logging import getLogger
# import json
import operator
from django.db.models import Q
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.template import RequestContext as ctx
from django.core.cache import cache
from django.views.decorators.cache import cache_page
from django.http import JsonResponse
from django.conf import settings
# from uuslug import uuslug
from datetime import date
from django.template.defaultfilters import safe, slugify

from django.views.decorators.csrf import csrf_exempt
from ratelimit.decorators import ratelimit
# from .templatetags import app_tags

from ..core.util.util import TextTemplateView,chunks
from ..web.models import Paises

from models import (CursosCategorias,Rubros,Cursos,Contenidos,Beneficios,Profesores,CursosDeInteres)
from .util import get_info, get_coors

from django.utils import translation
from django.utils.translation import ugettext as _

from ..pedidos.utilscart import (carrito_result, carrito_get_nro,)
# from ..custom_auth.utils import strip_tags
from django.core.urlresolvers import reverse, resolve


log = getLogger('django')

def arrayStrToArrayInt(arr):
	counter = 0
	for row in arr:
		arr[counter] = int(row)
		counter += 1
	if arr:
		return arr
	else:
		return None


def cursos(request, slug=False):
	log.info('VIEW: cursos')
	info = get_info()
	cat = get_object_or_404(CursosCategorias, slug=slug)
	query_py = {'active':True,'categoria':cat,'relacion__isnull':True}
	args_query = []
	# print request.GET

	if u'o' in request.GET.getlist('mod',[]):
		# print "Obtain For o"
		query_py.pop("relacion__isnull",None)
		args_query.append(Q(online=True))
		# query_py['online'] = True

	if u'c' in request.GET.getlist('mod',[]):
		# print "Obtain For c"
		query_py.pop("relacion__isnull",None)
		args_query.append(Q(classroom=True))
		# query_py['classroom'] = True

	if u'l' in request.GET.getlist('mod',[]):
		# print "Obtain For l"
		query_py.pop("relacion__isnull",None)
		args_query.append(Q(webcast=True))
		# query_py['webcast'] = True

	if args_query:
		qs_q = reduce(operator.or_,args_query)
	else:
		qs_q = Q()

	rubro = arrayStrToArrayInt(request.GET.getlist('rubro',[]))
	idiom = arrayStrToArrayInt(request.GET.getlist('idi',[]))
	if rubro:
		query_py['rubro__in'] = rubro

	if idiom:
		query_py['idiomas__in'] = idiom

	response = []
	query_py.pop("relacion__isnull",None) # Solicitaron evitar el filtro
	cursos = Cursos.objects.active().filter(qs_q,**query_py).order_by('posicion')
	request.wHead = cat.slug
	if request.method == 'POST':
		query_py = {'active':True,'categoria':cat,'relacion__isnull':True}
		args_query = []

		if u'o' in request.POST.getlist('mod',[]):
			# print "Obtain For o"
			query_py.pop("relacion__isnull",None)
			args_query.append(Q(online=True))
			# query_py['online'] = True

		if u'c' in request.POST.getlist('mod',[]):
			# print "Obtain For c"
			query_py.pop("relacion__isnull",None)
			args_query.append(Q(classroom=True))
			# query_py['classroom'] = True

		if u'l' in request.POST.getlist('mod',[]):
			# print "Obtain For l"
			query_py.pop("relacion__isnull",None)
			args_query.append(Q(webcast=True))
			# query_py['webcast'] = True

		rubro = arrayStrToArrayInt(request.POST.getlist('rubro',[]))
		idiom = arrayStrToArrayInt(request.POST.getlist('idi',[]))
		if rubro:
			query_py['rubro__in'] = rubro

		if idiom:
			query_py['idiomas__in'] = idiom


		if args_query:
			qs_q = reduce(operator.or_,args_query)
		else:
			qs_q = Q()
		response = []
		for row in Cursos.objects.filter(qs_q,**query_py)[:100]:
			response.append({
					"nombre":row.nombre,
					"fecha":"{0}/{1}/{2}".format(row.inicio.day,row.inicio.month,row.inicio.year),
					"nuevo":row.nuevo,
					"img":row.img.url,
					"link":reverse('cursos:curso', kwargs={'slug':row.slug}),
				})
		# print response
		return JsonResponse({"items":response},safe=True)

		# print len(cursos)

	return render('web/cursos.html', locals(), context_instance=ctx(request))


def curso(request, slug=False):
	log.info('VIEW: cursos')
	info = get_info()
	request.wHead = 'cursos'
	curso = get_object_or_404(Cursos,slug=slug)

	if request.method == 'POST':
		if request.user.is_authenticated():
			if not hasattr(request.user, 'is_client'):
				return render('superuser-noallowed.html', locals(),
				context_instance=ctx(request))
		cantidad = request.POST.get('cantidad', '')
		if cantidad:
			# ev = carrito_add_item(request, det.id, cantidad, det)
			result, suma, n, nro = carrito_result(request,'1', curso.id, cantidad)
			try:
				importe = float(cantidad)*float(curso.precio)
			except Exception as e:
				importe = 0
			# request.session['tmp_add'] = '%s' % importe
		return redirect('pedidos:carrito')


	paises = Paises.objects.all().order_by('nombre')
	request.wHead = curso.categoria.slug
	return render('web/curso.html', locals(), context_instance=ctx(request))
