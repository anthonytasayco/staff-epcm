# -*- coding: utf-8 -*-
from logging import getLogger

from django.forms import ModelForm
from django.template.loader import get_template
from django.template import Context
from django.core.mail import EmailMessage
from django.conf import settings

from django import forms

from .models import (Contacto, ContactoInformacion, Suscript, ContactoTrabajo, Destinatarios,LibRec)
from ..web.util import get_info
from utils import listMailClean

log = getLogger('django')
global STATIC_URL
STATIC_URL = settings.STATIC_URL

class ContactoForm(ModelForm):

	class Meta:
		model = Contacto
		fields = ('nombres','email', 'telefono', 'apellidos','mensaje')

	def enviaEmail(self):
		mailer, created = Destinatarios.objects.get_or_create(pk=1)
		htmly = get_template('email/contacto.html')
		info = get_info()
		c_d = self.cleaned_data
		c_d['STATIC_URL'] = (info.site + STATIC_URL)
		c_d['info'] = info
		d = Context(c_d)

		html_content = htmly.render(d)
		asunto = u"Web: Contacto"
		mail = u'{0}<{1}>'.format(settings.PROJECT_NAME,
			settings.DEFAULT_FROM_EMAIL)
		print(mailer.form_contacto.split(','))
		msg = EmailMessage(asunto, html_content, mail, mailer.form_contacto.split(','))
		msg.content_subtype = "html"
		msg.send()

class ContactoInformacionForm(ModelForm):

	class Meta:
		model = ContactoInformacion
		fields = ('nombres','email', 'telefono', 'pais','ciudad', 'empresa', 'curso','mensaje')

	def enviaEmail(self):
		mailer, created = Destinatarios.objects.get_or_create(pk=1)
		htmly = get_template('email/contacto_curso.html')
		info = get_info()
		c_d = self.cleaned_data
		c_d['STATIC_URL'] = (info.site + STATIC_URL)
		c_d['info'] = info
		d = Context(c_d)

		html_content = htmly.render(d)
		asunto = u"Web: Solicitud de información para {0}".format(c_d['curso'])
		mail = u'{0}<{1}>'.format(settings.PROJECT_NAME,
			settings.DEFAULT_FROM_EMAIL)
		print(mailer.form_contacto.split(','))
		msg = EmailMessage(asunto, html_content, mail, mailer.form_solicitud.split(','))
		msg.content_subtype = "html"
		msg.send()


class LibRecForm(ModelForm):

	class Meta:
		model = LibRec
		fields = ('nombres','apellidos', 'email', 'telefono','doc_type', 'doc_num', 'tipo','monto','descript')

	def enviaEmail(self):
		mailer, created = Destinatarios.objects.get_or_create(pk=1)
		htmly = get_template('email/libro_de_reclamaciones.html')
		info = get_info()
		c_d = self.cleaned_data
		c_d['STATIC_URL'] = (info.site + STATIC_URL)
		c_d['info'] = info
		d = Context(c_d)

		html_content = htmly.render(d)
		asunto = u"Web: Libro de Reclamaciones"
		mail = u'{0}<{1}>'.format(settings.PROJECT_NAME,
			settings.DEFAULT_FROM_EMAIL)
		print(mailer.form_contacto.split(','))
		msg = EmailMessage(asunto, html_content, mail,
						   listMailClean(mailer.form_reclamaciones),)
		msg.content_subtype = "html"
		msg.send()

class SuscriptForm(ModelForm):

	class Meta:
		model = Suscript
		fields = ('nombres','email')

	def enviaEmail(self):
		mailer, created = Destinatarios.objects.get_or_create(pk=1)
		htmly = get_template('email/suscript.html')
		info = get_info()
		c_d = self.cleaned_data
		c_d['STATIC_URL'] = (info.site + STATIC_URL)
		c_d['info'] = info
		d = Context(c_d)

		html_content = htmly.render(d)
		asunto = u"Web: Suscripción"
		mail = u'{0}<{1}>'.format(settings.PROJECT_NAME,
			settings.DEFAULT_FROM_EMAIL)
		msg = EmailMessage(asunto, html_content, mail,
						   listMailClean(mailer.form_suscript),)
		msg.content_subtype = "html"
		msg.send()


class ContactoTrabajoForm(ModelForm):

	class Meta:
		model = ContactoTrabajo
		fields = ('nombres','telefono','email','adjunto')

	def enviaEmail(self,trabajoContacto):
		mailer, created = Destinatarios.objects.get_or_create(pk=1)
		htmly = get_template('email/trabaja.html')
		info = get_info()
		c_d = self.cleaned_data
		c_d['STATIC_URL'] = (info.site + STATIC_URL)
		c_d['trabajoContacto'] = trabajoContacto
		c_d['info'] = info
		d = Context(c_d)

		html_content = htmly.render(d)
		asunto = u"Web: Postulante de trabajo"
		mail = u'{0}<{1}>'.format(settings.PROJECT_NAME,
			settings.DEFAULT_FROM_EMAIL)
		msg = EmailMessage(asunto, html_content, mail,
						   listMailClean(mailer.form_trabajo),)
		msg.content_subtype = "html"
		msg.send()




