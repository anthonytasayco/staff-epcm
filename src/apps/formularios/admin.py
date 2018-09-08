# -*- coding: utf-8 -*-
from django.conf import settings
from django.contrib import admin
from django.contrib.sites.models import Site
from django.contrib.auth.models import Group

from ..core.actions import export_as_xls
from .models import Contacto, SociosContacto, Suscript, Destinatarios, ContactoInformacion, LibRec

STATIC_URL = settings.STATIC_URL
from singlemodeladmin import SingleModelAdmin


@admin.register(Contacto)
class ContactoAdmin(admin.ModelAdmin):
	model = Contacto
	list_display = ('nombres', 'email', 'fecha')
	list_per_page = 64
	list_filter = ['fecha']
	search_fields = ('email', 'telefono')
	ordering = ['-fecha']
	actions = [export_as_xls]
	
	def get_readonly_fields(self, request, obj=None):
		if request.user.has_perm('formularios.Contacto'):
			if obj:
				self.readonly_fields = [field.name for field in obj.__class__._meta.fields]
			return self.readonly_fields

	def has_add_permission(self, request):
		return False


@admin.register(ContactoInformacion)
class ContactoInformacionAdmin(admin.ModelAdmin):
	model = ContactoInformacion
	list_display = ('nombres', 'email', 'fecha')
	list_per_page = 64
	list_filter = ['fecha']
	search_fields = ('email', 'telefono')
	ordering = ['-fecha']
	actions = [export_as_xls]
	
	def get_readonly_fields(self, request, obj=None):
		if request.user.has_perm('formularios.ContactoInformacion'):
			if obj:
				self.readonly_fields = [field.name for field in obj.__class__._meta.fields]
			return self.readonly_fields

	def has_add_permission(self, request):
		return False


@admin.register(LibRec)
class LibRecAdmin(admin.ModelAdmin):
	model = LibRec
	list_display = ('nombres', 'email', 'telefono', 'doc_num', 'tipo', 'monto')
	list_per_page = 64
	list_filter = ['fecha']
	search_fields = ('email', 'telefono')
	ordering = ['-fecha']
	actions = [export_as_xls]
	
	def get_readonly_fields(self, request, obj=None):
		if request.user.has_perm('formularios.LibRec'):
			if obj:
				self.readonly_fields = [field.name for field in obj.__class__._meta.fields]
			return self.readonly_fields

	def has_add_permission(self, request):
		return False



# @admin.register(SociosContacto)
class SociosContactoAdmin(admin.ModelAdmin):
	model = SociosContacto
	list_display = ('nombres', 'email', 'fecha')
	list_per_page = 64
	list_filter = ['fecha']
	search_fields = ('email', 'telefono')
	ordering = ['-fecha']
	actions = [export_as_xls]
	
	def get_readonly_fields(self, request, obj=None):
		if request.user.has_perm('web.SociosContacto'):
			if obj:
				self.readonly_fields = [field.name for field in obj.__class__._meta.fields]
			return self.readonly_fields

	def has_add_permission(self, request):
		return False


@admin.register(Suscript)
class SuscriptAdmin(admin.ModelAdmin):
	model = Suscript
	list_display = ('email', 'fecha')
	list_filter = ['fecha']
	list_per_page = 64
	ordering = ['-fecha']
	actions = [export_as_xls]

	def get_readonly_fields(self, request, obj=None):
		if request.user.has_perm('formularios.Suscript'):
			if obj:
				self.readonly_fields = [field.name for field in obj.__class__._meta.fields]
			return self.readonly_fields

	def has_add_permission(self, request):
		return False


@admin.register(Destinatarios)
class SuscriptAdmin(SingleModelAdmin):
	model = Destinatarios

