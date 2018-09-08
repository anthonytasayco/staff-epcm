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


class HomeEventosSeccion(models.Model):
	#Banner
	cabecera = models.CharField("Títuloo de banner", max_length=128)
	#Eventos Seccion
	b_titulo = models.CharField("Título", max_length=128)
	b_descript = RichTextField(config_name='small', verbose_name='Descripción')


	class Meta:
		verbose_name = u'Eventos Sección'
		verbose_name_plural = u'Eventos Sección'

	def __unicode__(self):
		return u'Eventos Sección'


class EventosSociales(AuditableModel, SlugModel):
	nombre = models.CharField("Nombre de Evento", max_length=512)
	fecha = models.DateField("Fecha de evento",default=date.today)
	img =FileBrowseField('Imagen de evento',max_length=200, directory='eventos_imgs/', extensions=['.jpg', '.png'])
	descript = RichTextField(config_name='small', verbose_name='Descripción (extensa)')

	class Meta:
		verbose_name = u'Evento'
		verbose_name_plural = u'Eventos'
		ordering = ['-fecha']

	def __unicode__(self):
		return u'{0}'.format(self.nombre,)

class HomeNoticiasSeccion(models.Model):
	#Banner
	cabecera = models.CharField("Título de banner", max_length=128)
	#Eventos Seccion
	b_titulo = models.CharField("Título", max_length=128)
	b_descript = RichTextField(config_name='small', verbose_name='Descripción')

	class Meta:
		verbose_name = u'Noticias Sección'
		verbose_name_plural = u'Noticias Sección'

	def __unicode__(self):
		return u'Noticias Sección'

class Noticias(AuditableModel, SlugModel):
	fecha = models.DateField("Fecha de Publicación", default=date.today)
	nombre = models.CharField('Titular de Noticia', max_length=256)
	nombre_x = models.CharField('Titular de Noticia (2Líneas)', max_length=258, help_text='use // para dividir el texto')
	img =FileBrowseField('Imagen de Noticia',max_length=200, directory='noticias_imgs/', extensions=['.jpg', '.png'])
	descript = RichTextField(config_name='small', verbose_name='Descripción')

	def name_complex(self):
		if self.nombre_x:
			splt = self.nombre_x.split('//')
			if len(splt) > 1:
				return u'{0} <strong>{1}</strong>'.format(splt[0],splt[1])
			else:
				return self.nombre_x
		else:
			return self.nombre


	class Meta:
		verbose_name = u'Noticia'
		verbose_name_plural = u'Noticias'
		ordering = ['-fecha']

	def __unicode__(self):
		return u'{0}'.format(self.nombre,)
