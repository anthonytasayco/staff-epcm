# -*- coding: utf-8 -*-

# IMPORTS
from datetime import date
from logging import getLogger
from urlparse import urlparse
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.template.defaultfilters import safe
#tranlate imports
from ckeditor.fields import RichTextField
from django.conf import settings
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db import models

# from smart_selects.db_fields import ChainedForeignKey
from ..core.models import AuditableModel, SlugModel, PositionModel
from geoposition.fields import GeopositionField
from filebrowser.fields import FileBrowseField
from killertags import html_to_text as safetxt, name_cleaner
from choices import *

# from models_a import *
# from models_b import *
# from models_c import *

log = getLogger('django')

enlace_help_text='''En caso de ser un enlace interno debe empezar con '/'\
<br>Ejemplo: <strong>/nosotros</strong><br> En caso de enlace Externo\
 debe empezar con http o https Ejemplo: <strong>http://</strong>www.ccapudev.com/es/'''

sf_strg = 'encerrar el texto a resaltar con < >'


class TermsSeccion(models.Model):
	#Banner
	cabecera = models.CharField("Títuloo de banner", max_length=128)
	#Eventos Seccion
	b_titulo = models.CharField("Título", max_length=128, help_text='encien en < > el texto a resaltar')

	class Meta:
		verbose_name = u'Terminos Sección'
		verbose_name_plural = u'Terminos Sección'

	def __unicode__(self):
		return u'Terminos Sección'


class Terms(AuditableModel, SlugModel):
	nombre = models.CharField("Termino", max_length=256, blank=True)
	descript = RichTextField(config_name='small', verbose_name='Descripción')
	posicion = models.PositiveIntegerField("Posición", default=1)

	class Meta:
		verbose_name = u'termino'
		verbose_name_plural = u'Terminos'
		ordering = ['posicion']

	def __unicode__(self):
		return u'{0}'.format(self.nombre,)

class QuestSeccion(models.Model):
	#Banner
	cabecera = models.CharField("Título de banner", max_length=128)
	#Eventos Seccion
	b_titulo = models.CharField("Título", max_length=128, help_text='encien en < > el texto a resaltar')

	class Meta:
		verbose_name = u'Preguntas Sección'
		verbose_name_plural = u'Preguntas Sección'

	def __unicode__(self):
		return u'Preguntas Sección'

class Quest(AuditableModel, SlugModel):
	nombre = models.CharField('Pregunta', max_length=256)
	descript = RichTextField(config_name='small', verbose_name='Descripción')
	posicion = models.PositiveIntegerField("Posición", default=1)

	class Meta:
		verbose_name = u'Pregunta frecuente'
		verbose_name_plural = u'Preguntas frecuentes'
		ordering = ['posicion']

	def __unicode__(self):
		return u'{0}'.format(self.nombre,)
