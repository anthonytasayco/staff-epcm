# -*- coding: utf-8 -*-
from django.conf import settings
from django.contrib import admin
from django.contrib.sites.models import Site
from django.contrib.auth.models import Group

import models
from filebrowser.settings import ADMIN_THUMBNAIL
from ..core.actions import export_as_xls
from singlemodeladmin import SingleModelAdmin



STATIC_URL = settings.STATIC_URL
js_tiny = [
	'{0}grappelli/tinymce/jscripts/tiny_mce/tiny_mce.js'.format(STATIC_URL),
	'{0}grappelli/tinymce_setup/tinymce_setup.js'.format(STATIC_URL),
]
js_external = [
	'{0}js/external_admin_fixes.js?prod=true'.format(STATIC_URL)
]
seo_link = [
	'{0}js/SEOLink.js'.format(STATIC_URL)
]

from modeltranslation.admin import TranslationAdmin, TranslationStackedInline, TranslationTabularInline
class TranslationAdmin(TranslationAdmin):
	class Media:
		js = js_external
		
@admin.register(models.TermsSeccion)
class TermsSeccionAdmin(SingleModelAdmin,TranslationAdmin):
	model = models.TermsSeccion
	list_display = ['__unicode__']
	fieldsets = (
		('Banner', {'fields': ('cabecera',)}),
		('Bloque', {'fields': ('b_titulo',)})
	)
	# ordering = ['posicion']

@admin.register(models.Terms)
class TermsAdmin(TranslationAdmin):
	model = models.Terms
	list_display = ['__unicode__','posicion']
	# fieldsets = (
	# 	('Banner', {'fields': ('titulo','detalle','banner')}),
	# 	('Bloque Informativo', {'fields': ('img','b_titulo','b_detalle', 'b_descript', 'archivo')}),
	# )
	ordering = ['posicion']


@admin.register(models.QuestSeccion)
class QuestSeccionAdmin(SingleModelAdmin,TranslationAdmin):
	model = models.QuestSeccion
	list_display = ['__unicode__']
	fieldsets = (
		('Banner', {'fields': ('cabecera',)}),
		('Bloque', {'fields': ('b_titulo',)})
	)

@admin.register(models.Quest)
class QuestAdmin(TranslationAdmin):
	model = models.Quest
	list_display = ['__unicode__','posicion']
	# fieldsets = (
	# 	('Banner', {'fields': ('titulo','detalle','banner')}),
	# 	('Bloque Informativo', {'fields': ('img','b_titulo','b_detalle', 'b_descript', 'archivo')}),
	# )
	# inlines=[StaffInline]
	ordering = ['posicion']


# class YearsInline(admin.StackedInline):
# 	model = models.Years
# 	# sortable_field_name = 'posicion'
# 	ordering = ['year']
# 	extra = 0

# @admin.register(models.Historia)
# class HistoriaAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = models.Historia
# 	list_display = ['__unicode__']
# 	fieldsets = (
# 		(u'Sección indexada en la pantalla principal', {'fields': ('active','cabecera','titulo','descript','img','link_to')}),
# 		('Bloque Informativo', {'fields': ('banner_titulo','banner_detalle','banner')}),
# 		(u'Sección de Historia', {'fields': ('lt_titulo','lt_descript')}),
# 	)
# 	inlines=[YearsInline]


# class RSItemsInline(admin.StackedInline):
# 	model = models.RSItems
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

# @admin.register(models.ResponsabilidadSocial)
# class ResponsabilidadSocialAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = models.ResponsabilidadSocial
# 	list_display = ['__unicode__']
# 	inlines = [RSItemsInline]

# @admin.register(models.HomeSeccion)
# class HomeSeccionAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = models.HomeSeccion
# 	list_display = ['__unicode__']
# 	fieldsets = (
# 		('Banner', {'fields': ('titulo','detalle','banner')}),
# 		('Bloque Informativo', {'fields': ('img','b_titulo','b_detalle', 'b_descript', 'archivo')}),
# 	)
# 	# ordering = ['posicion']


# class StaffInline(admin.StackedInline):
# 	model = Staff
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0


# @admin.register(models.SectoresDeStaff)
# class SectoresDeStaffAdmin(TranslationAdmin):
# 	model = models.SectoresDeStaff
# 	list_display = ['__unicode__']
# 	# fieldsets = (
# 	# 	('Banner', {'fields': ('titulo','detalle','banner')}),
# 	# 	('Bloque Informativo', {'fields': ('img','b_titulo','b_detalle', 'b_descript', 'archivo')}),
# 	# )
# 	inlines=[StaffInline]
# 	ordering = ['posicion']


# class YearsInline(admin.StackedInline):
# 	model = Years
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

# @admin.register(models.Historia)
# class HistoriaAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = models.Historia
# 	list_display = ['__unicode__']
# 	fieldsets = (
# 		(u'Sección indexada en la pantalla principal', {'fields': ('active','cabecera','titulo','descript','img','link_to')}),
# 		('Bloque Informativo', {'fields': ('banner_titulo','banner_detalle','banner')}),
# 		(u'Sección de Historia', {'fields': ('lt_titulo','lt_descript')}),
# 	)
# 	inlines=[YearsInline]


# class RSItemsInline(admin.StackedInline):
# 	model = RSItems
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

# @admin.register(models.ResponsabilidadSocial)
# class ResponsabilidadSocialAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = models.ResponsabilidadSocial
# 	list_display = ['__unicode__']
# 	inlines = [RSItemsInline]

# class TestimoniosInline(admin.StackedInline):
# 	model = Testimonios
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

# class ClientesInline(admin.TabularInline):
# 	model = Clientes
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

# @admin.register(ClientesTestimonios)
# class ClientesTestimoniosAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = ClientesTestimonios
# 	readonly_fields = ['nombre']
# 	inlines = [TestimoniosInline,ClientesInline]



# class NosotrosValoresInline(admin.StackedInline):
# 	model = NosotrosValores
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

	
# @admin.register(Nosotros)
# class NosotrosAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = Nosotros
# 	inlines = [NosotrosValoresInline]
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']
	
# # @admin.register(NosotrosValores)
# # class NosotrosValoresAdmin(TranslationAdmin):
# # 	model = NosotrosValores
# # 	# list_display = ['__unicode__']
# # # 	fieldsets = (
# # # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # # 	)
# # 	# ordering = ['posicion']


# class ServicioGaleryInline(admin.TabularInline):
# 	model = ServicioGalery
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

# class ServicioTabsInline(admin.StackedInline):
# 	model = ServicioTabs
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0


# @admin.register(Servicios)
# class ServiciosAdmin(TranslationAdmin):
# 	model = Servicios
# 	inlines = [ServicioGaleryInline,ServicioTabsInline]
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']
	

# @admin.register(LesionesSeccion)
# class LesionesSeccionAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = LesionesSeccion
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']
	
# @admin.register(Lesiones)
# class LesionesAdmin(TranslationAdmin):
# 	model = Lesiones
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']
	
# @admin.register(ContactoSeccion)
# class ContactoSeccionAdmin(SingleModelAdmin,TranslationAdmin):
# 	model = ContactoSeccion
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']

