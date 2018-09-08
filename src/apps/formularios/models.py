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

from geoposition.fields import GeopositionField
from filebrowser.fields import FileBrowseField
from ckeditor.fields import RichTextField

log = getLogger('django')

ht_dest = "separe los email por comas"

class Destinatarios(models.Model):
	form_contacto = models.CharField('Destinatarios de formulario Contacto',
					 max_length=1024, help_text=ht_dest)
	form_reclamaciones = models.CharField('Destinatarios de libro de reclamaciones',
					 max_length=1024, help_text=ht_dest)
	form_solicitud = models.CharField('Destinatarios de solicitud de información',
					 max_length=1024, help_text=ht_dest)
	form_suscript = models.CharField('Destinatarios de Suscripciones',
					 max_length=1024, help_text=ht_dest, editable=True)
	form_trabajo = models.CharField('Destinatarios de Postulantes de trabajo',
					 max_length=1024, help_text=ht_dest, editable=False)
	form_socios = models.CharField('Destinatarios de formulario de socios',
					 max_length=1024, help_text=ht_dest, editable=False)

	class Meta:
		verbose_name = u'Destinatarios'
		verbose_name_plural = u'Destinatarios de formularios'

	def __unicode__(self):
		return 'Destinatarios'


class Contacto(models.Model):
	fecha = models.DateTimeField('Fecha', auto_now_add=True)
	nombres = models.CharField('Nombres', max_length=120)
	apellidos = models.CharField('Apellidos', max_length=120)
	email = models.EmailField('Email')
	telefono = models.CharField('Telefono', max_length=120)
	mensaje = models.TextField('Mensaje')

	class Meta:
		verbose_name = u'Contacto'
		verbose_name_plural = u'Contactos'
		ordering = ['-fecha']

	def __unicode__(self):
		return '{0}: {1}'.format(self.email, self.fecha.date())


class LibRec(models.Model):
	fecha = models.DateTimeField('Fecha', auto_now_add=True)
	nombres = models.CharField('Nombres', max_length=120)
	apellidos = models.CharField('Apellidos', max_length=120)
	email = models.EmailField('Email')
	telefono = models.CharField('Telefono', max_length=120)
	doc_type = models.CharField("Tipo de Documento", max_length=50)
	doc_num = models.CharField("N° de Documento", max_length=50)
	tipo = models.CharField("Tipo de bien contratado", max_length=128)
	monto = models.CharField("Monto de reclamo", max_length=128)
	descript = models.TextField('Descripción')

	class Meta:
		verbose_name = u'Libro de reclamaciones'
		verbose_name_plural = u'Libro de reclamaciones'
		ordering = ['-fecha']

	def __unicode__(self):
		return '{0}: {1}'.format(self.email, self.fecha.date())


class ContactoInformacion(models.Model):
	fecha = models.DateTimeField('Fecha', auto_now_add=True)
	nombres = models.CharField('Nombres', max_length=120)
	email = models.EmailField('Email')
	telefono = models.CharField('Telefono', max_length=120)
	pais = models.CharField('País', max_length=120, blank=True)
	ciudad = models.CharField('Ciudad', max_length=120, blank=True)
	empresa = models.CharField('Empresa', max_length=120, blank=True)
	curso = models.CharField('Curso', max_length=120)
	mensaje = models.TextField('Mensaje')

	class Meta:
		verbose_name = u'solicitud de información de curso'
		verbose_name_plural = u'Solicitudes de información'
		ordering = ['-fecha']

	def __unicode__(self):
		return '{0}: {1}'.format(self.email, self.fecha.date())

class SociosContacto(models.Model):
	fecha = models.DateTimeField('Fecha', auto_now_add=True)
	nombres = models.CharField('Nombres', max_length=120)
	email = models.EmailField('Email')
	telefono = models.CharField('Telefono', max_length=120)
	empresa = models.CharField('Empresa', max_length=120)
	mensaje = models.TextField('Mensaje')

	class Meta:
		verbose_name = u'Contacto Socio'
		verbose_name_plural = u'Contactos Socios'
		ordering = ['-fecha']

	def __unicode__(self):
		return '{0}: {1}'.format(self.email, self.fecha.date())


class ContactoTrabajo(models.Model):
	fecha = models.DateTimeField('Fecha', auto_now_add=True)
	telefono = models.CharField('Trabajo', max_length=256, blank=True)
	nombres = models.CharField('Nombres', max_length=120)
	email = models.EmailField('Email')
	adjunto = models.FileField('Adjunto', upload_to='cv-trabajo/')

	class Meta:
		verbose_name = u'Contacto'
		verbose_name_plural = u'Contactos de Trabajo'
		ordering = ['-fecha']

	def __unicode__(self):
		return '{0}: {1}'.format(self.nombres, self.fecha.date())


class Suscript(models.Model):
	fecha = models.DateTimeField('Fecha', auto_now_add=True)
	nombres = models.CharField('Nombres', max_length=120)
	email = models.EmailField('Email')

	class Meta:
		verbose_name = u'suscriptor'
		verbose_name_plural = u'Suscriptores'
		ordering = ['-fecha']

	def __unicode__(self):
		return '{0}: {1}'.format(self.email, self.fecha.date())

