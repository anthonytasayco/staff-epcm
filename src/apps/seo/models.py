# -*- coding: utf-8 -*-

# IMPORTS
from datetime import date
from logging import getLogger
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
#tranlate imports
from django.conf import settings
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db import models

from ..core.models import AuditableModel, SlugModel, PositionModel

log = getLogger('django')

class InfoSeo(models.Model):
	seo_alerts = models.BooleanField("Notificar errores?", default=False)
	emails_support = models.CharField('Notificar de errores a...', blank=True, max_length=512,
					help_text='separe los correos con comas', default='seo@staffcreativa.com')

	def array_mails_support(self):
		emails = self.emails_support.split(',')
		email_array = []
		for row in emails:
			email_array.append(row.strip())
		return email_array


	class Meta:
		verbose_name = u'Configuración General'
		verbose_name_plural = u'a) Configuración General'

	def __unicode__(self):
		return u'Info SEO'


################################################ SEO y Diccionario #####################################################
class URLRegister(models.Model):
	url = models.CharField('URL', max_length=1024, unique=True)

	class Meta:
		verbose_name = u'url'
		verbose_name_plural = u'b) Registros de URLs'

	def __unicode__(self):
		return u'{0}'.format(self.url,)
		

class SEOTags(AuditableModel):
	url_seo = models.CharField('URL', max_length=1024, unique=True)
	title = models.CharField('Titulo', max_length=70, blank=True)
	descript = models.TextField('Descripción', max_length=160, blank=True)
	extend = models.TextField('Tags Extras', blank=True, help_text='Colocar html puro \
																		 (tags para facebook, twitter etc...)')

	class Meta:
		verbose_name = u'Título y descripción'
		verbose_name_plural = u'c) Títulos y descripciones'

	# def get_absolute_url(self):
	# 	return self.url_seo

	def save(self, *args, **kwargs):
		url,created = URLRegister.objects.get_or_create(url=self.url_seo)
		super(SEOTags, self).save(*args, **kwargs)

	def __unicode__(self):
		return u'{0}'.format(self.url_seo,)
		

class SEORedirects(AuditableModel):
	url_in = models.CharField('URL', max_length=1024, unique=True)
	url_out = models.CharField('redireccionará a', max_length=1024, blank=True, default='/',
								help_text='si este campo esta vacío, retornará (410:Ya no disponible) \
											 Por defecto dirige al home /')
	code_type = models.SmallIntegerField('Tipo', default=302)

	class Meta:
		verbose_name = u'redirección'
		verbose_name_plural = u'd) Redireccionamientos'

	def __unicode__(self):
		return u'{0}'.format(self.url_in,)