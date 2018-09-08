# -*- coding: utf-8 -*-
from logging import getLogger
import json
import requests
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.template import RequestContext as ctx
from django.core.cache import cache
from django.core import serializers

from django.views.decorators.cache import cache_page
from django.http import JsonResponse
from django.conf import settings
# from uuslug import uuslug
from django.template.defaultfilters import safe, slugify

from django.views.decorators.csrf import csrf_exempt
from ratelimit.decorators import ratelimit
from .templatetags import app_tags

from ..core.util.util import TextTemplateView,chunks

from models import (InfoSite,Sliders,PorqueElegirnos,Conocenos,Clientes,Respaldos,
                    Paises,TranslaterDicc,ContactoSeccion,LibroSeccion,
                    SeccionInferior, Blog)
from ..cursos.models import CursosDeInteres,Profesores
from ..eventos_noticias.models import EventosSociales, Noticias
from .util import get_info, get_coors

from django.utils import translation
from django.utils.translation import ugettext as _

from django.core.urlresolvers import reverse, resolve

log = getLogger('django')

def api_blog(request):
    npublicaciones = 4
    url = 'https://epcm.academy/blog/wp-json/wp/v2/posts'
    data = {
        'per_page': npublicaciones,
        'page': 1,
        'status': 'publish'
    };
    prueba = Blog.objects.order_by('-createdat').all()
    pp = serializers.serialize('json', prueba)
    r = requests.get(url, params=data, verify=False)
    rspt = json.loads(r.content)
    response = []
    for post in rspt:
        rmedia = requests.get('https://epcm.academy/blog/wp-json/wp/v2/media/' + str(post['featured_media']), verify=False)
        if rmedia.status_code == 200:
            rsptmedia = json.loads(rmedia.content)
            media = rsptmedia['guid']['rendered']
        else:
            media = ''
        Blog.objects.create(
            postid=post['id'],
            imagen= media,
            title= post['title']['rendered'],
            excerpt= post['excerpt']['rendered'],
            link= post['link'],
            createdat= post['date'],
            )
        # response.append({
        #     'postid': post['id'],
        #     'image': media,
        #     'title': post['title']['rendered'],
        #     'excerpt': post['excerpt']['rendered'],
        #     'link': post['link'],
        #     'createdat': post['date'],
        # })
    return JsonResponse({'data':'success'}, safe=True)



def home(request):
    log.info('VIEW: home')
    head = 'home'
    sliders = Sliders.objects.active().order_by('posicion')
    p_e = PorqueElegirnos.objects.active().order_by('posicion')[:3]
    cursos, created = CursosDeInteres.objects.get_or_create(pk=1)
    seccion, created = Conocenos.objects.get_or_create(pk=1)
    eventos = EventosSociales.objects.active().order_by('-fecha')[:3]
    noticias = Blog.objects.order_by('-createdat')[:2]

    inf_seccion, created = SeccionInferior.objects.get_or_create(pk=1)

    return render('web/home.html', locals(), context_instance=ctx(request))

def conocenos(request):
    log.info('VIEW: conocenos')
    head = 'conocenos'
    p_e = PorqueElegirnos.objects.active().order_by('posicion')
    seccion, created = Conocenos.objects.get_or_create(pk=1)
    docentes = Profesores.objects.active().order_by('posicion')[:12]
    return render('web/conocenos.html', locals(), context_instance=ctx(request))

def librec(request):
    log.info('VIEW: librec')
    head = 'librec'
    seccion, created = LibroSeccion.objects.get_or_create(pk=1)
    return render('web/libro-reclamaciones.html', locals(), context_instance=ctx(request))


def contacto(request):
    log.info('VIEW: contacto')
    head = 'contacto'
    seccion, created = ContactoSeccion.objects.get_or_create(pk=1)
    errors = request.session.get('error_form','')
    if errors:
        request.session['error_form'] = ''
    return render('web/contacto.html', locals(), context_instance=ctx(request))

# BackEND
def page_404(request):
    ruta = request.path
    log.error('Error 404: {0}'.format(ruta))
    head = '404'
    response = render('404.html', locals(), context_instance=ctx(request))
    response.status_code = 404
    response.reason_phrase = "Page No Found!! - "+settings.PROJECT_NAME.title()
    return response


def page_500(request):
    ruta = request.path
    log.error('Error 500: {0}'.format(ruta))
    response = render('500.html', locals(), context_instance=ctx(request))
    response.status_code = 500
    response.reason_phrase = "Server Conflict!! - "+settings.PROJECT_NAME.title()
    return response

# EXTRA
class RobotsView(TextTemplateView):
    template_name = "extra/robots.txt"

    def get_context_data(self, **kwargs):
        log.info('VIEW: RobotsView')
        return {'url_base': get_info().site, 'project_name': get_info().titulo}


def contacto_ok(request):
    ''' Redirecciona url's del admin '''
    return render('web/enviado.html', locals(), context_instance=ctx(request))


def ratelimit_view(request):
    ''' Vista lanzada al activar el bloqueo de django-ratelimit '''
    log.info('VIEW: ratelimit_view')

    return render('web/ratelimit.html', locals(), context_instance=ctx(request))


def base_template(request,template_name='web/',slug=''):
    log.info('VIEW: base_template')
    head = 'ignore'
    try:
        return render(template_name+slug+'.html', locals(), context_instance=ctx(request))
    except Exception, e:
        return JsonResponse({'status':"Archivo Inexistente."}, safe=True)
