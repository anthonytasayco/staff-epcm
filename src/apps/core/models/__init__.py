# -*- coding: utf-8 -*-

from logging import getLogger
from django.db import models

from uuslug import uuslug

from .managers import ActiveInactiveManager

log = getLogger('django')


class AuditableModel(models.Model):
	active = models.BooleanField('Activo', default=True)
	created = models.DateTimeField(editable=False, auto_now_add=True)
	modified = models.DateTimeField(editable=False, auto_now=True)
	created_by = models.IntegerField('Creado por', editable=False, null=True,
									 default=0)
	modified_by = models.IntegerField('Modificado por', editable=False,
									  null=True, default=0)

	objects = ActiveInactiveManager()

	class Meta:
		abstract = True


class SlugModel(models.Model):
	# nombre = models.CharField('Nombre', max_length=120)
	slug = models.SlugField('slug', max_length=180, blank=True, editable=True)

	class Meta:
		abstract = True

	def __unicode__(self):
		return self.nombre

	def save(self, *args, **kwargs):
		if hasattr(self,'nombre_es'):
			self.slug = uuslug(self.nombre_es, instance=self)
			super(SlugModel, self).save(*args, **kwargs)
		else:
			self.slug = uuslug(self.nombre, instance=self)
			super(SlugModel, self).save(*args, **kwargs)


class PositionModel(models.Model):
	position = models.SmallIntegerField('Posición', default=0)

	class Meta:
		abstract = True
		ordering = ['position']


def wCleanGETvars(getvars):
	if '?' in getvars:
		getvars = getvars.split('?')[0]
	if '&' in getvars:
		getvars = getvars.split('&')[0]
	return getvars

def wYoutubeGetID(id_instance,link_instance):
	if id_instance in link_instance and id_instance != '':
		return id_instance
	elif link_instance.startswith('https://youtu.be/'):
		return wCleanGETvars(link_instance.replace('https://youtu.be/',''))

	elif link_instance.startswith('https://www.youtube.com/embed/'):
		return wCleanGETvars(link_instance.replace('https://www.youtube.com/embed/',''))

	elif link_instance.startswith('https://www.youtube.com/watch?v='):
		return wCleanGETvars(link_instance.replace('https://www.youtube.com/watch?v=',''))
	else:
		return 'link-de-youtube-erroneo'