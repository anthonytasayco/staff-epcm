# -*- coding: utf-8 -*-
from logging import getLogger
# import json
from django.http import Http404

from django.template import RequestContext as ctx
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.core.cache import cache
from django.conf import settings
# from uuslug import uuslug
from ratelimit.decorators import ratelimit

from .models import Suscript
from ..cursos.models import Cursos
from ..web.models import Paises
from .utils import form_verify

from django.core.urlresolvers import reverse, resolve
from .forms import ContactoForm, SuscriptForm, ContactoTrabajoForm, ContactoInformacionForm, LibRecForm

from django.utils import translation
from django.utils.translation import ugettext as _

import threading
log = getLogger('django')

type_dict = {
	"0":False,
	"1":"DNI",
	"2":"Pasaporte",
	"3":"Licencia",
	"4":"Libreta",
}


#@ratelimit(key='ip', rate='20/h', method=ratelimit.UNSAFE)
#@form_verify
def contacto(request):
	#log.info('VIEW: contacto')
	head = 'contacto'
	was_limited = getattr(request, 'limited', False)
	if was_limited:
		return ratelimit_view(request)
	if request.method == 'POST':
		#log.info('HOME : POST')
		form = ContactoForm(request.POST)
		if form.is_valid():
			form.save()
			form.enviaEmail()
			# threading.Thread(target=form.enviaEmail,).start()
			return redirect(reverse("contacto_enviado"))
		else:
			request.session['error_form'] = form.errors.as_text()
                        print(form.errors.as_text())
			return redirect(reverse("contacto"))

	else:
		form = ContactoForm()

	return render('web/contacto.html', locals(), context_instance=ctx(request))


#@ratelimit(key='ip', rate='20/h', method=ratelimit.UNSAFE)
#@form_verify
def curso(request, slug=False):
	#log.info('VIEW: contacto')
	head = 'contacto'
	was_limited = getattr(request, 'limited', False)
	if was_limited:
		return ratelimit_view(request)
	if request.method == 'POST':
		#log.info('HOME : POST')
		#request.POST._mutable = True
                #request.POST['curso'] = get_object_or_404(Cursos, slug=slug)
		#request.POST['pais'] = get_object_or_404(Paises, pk=request.POST.get('pais',0))
                print(request.POST)
		form = ContactoInformacionForm(request.POST)
		if form.is_valid():
			form.save()
                        form.enviaEmail()
			#threading.Thread(target=form.enviaEmail,).start()
			return redirect(reverse("contacto_enviado"))
		else:
			print(form.errors.as_text())
                        request.session['error_form'] = form.errors
	else:
		form = ContactoInformacionForm()

	return render('web/contacto.html', locals(), context_instance=ctx(request))


#@ratelimit(key='ip', rate='20/h', method=ratelimit.UNSAFE)
#@form_verify
def suscript(request):
	#log.info('VIEW: suscript')
	head = 'contacto'
	was_limited = getattr(request, 'limited', False)
	if was_limited:
		return ratelimit_view(request)
	if request.method == 'POST':
		#log.info('HOME : POST')
		old_suscript = Suscript.objects.filter(email=request.POST.get('email')).first()
		form = SuscriptForm(request.POST)
		if form.is_valid():
			if old_suscript:
				return redirect(reverse("suscript_enviado"))
			else:
				form.save()
                                form.enviaEmail()
				# threading.Thread(target=form.enviaEmail,).start()
			return redirect(reverse("suscript_enviado"))
		else:
			print(form.errors)
                        request.session['error_form'] = form.errors
		print form.errors
	else:
		form = SuscriptForm()
	return render('web/form-suscript.html', locals(), context_instance=ctx(request))




#@ratelimit(key='ip', rate='20/h', method=ratelimit.UNSAFE)
#@form_verify
def librec(request):
	head = 'librec'
	was_limited = getattr(request, 'limited', False)
	if was_limited:
		return ratelimit_view(request)
	if request.method == 'POST':
		if type_dict.get(request.POST.get('doc_type','0'),False):
                        request.POST._mutable = True
			request.POST['doc_type'] = type_dict.get(request.POST.get('doc_type'))
		else:
			raise Http404
		form = LibRecForm(request.POST)
		if form.is_valid():
			form.save()
                        form.enviaEmail()
			# threading.Thread(target=form.enviaEmail,).start()
			return redirect(reverse("reclamo_enviado"))
		else:
			print(form.errors.as_text())
                        request.session['error_form'] = form.errors.as_text()
			return redirect(reverse("librec"))
	else:
		form = LibRecForm()
	return render('web/contacto.html', locals(), context_instance=ctx(request))


def contacto_ok(request):
	#log.info('VIEW: contacto_ok')
	head = 'contacto'

	return render('web/enviado.html', locals(), context_instance=ctx(request))
