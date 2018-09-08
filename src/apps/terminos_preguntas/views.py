# -*- coding: utf-8 -*-
from logging import getLogger
# import json

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

from models import (TermsSeccion,Terms,QuestSeccion,Quest)
from .util import get_info, get_coors

from django.utils import translation
from django.utils.translation import ugettext as _

from django.core.urlresolvers import reverse, resolve

log = getLogger('django')


def terms(request):
	log.info('VIEW: home')
	info = get_info()
	request.wHead = 'terms'
	seccion, created = TermsSeccion.objects.get_or_create(pk=1)
	terminos = Terms.objects.active().order_by('posicion')
	return render('web/terminos-y-condiciones.html', locals(), context_instance=ctx(request))

def quests(request):
	log.info('VIEW: home')
	info = get_info()
	request.wHead = 'quests'
	seccion, created = QuestSeccion.objects.get_or_create(pk=1)
	preguntas = Quest.objects.active().order_by('posicion')
	return render('web/preguntas-frecuentes.html', locals(), context_instance=ctx(request))