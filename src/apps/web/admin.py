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


@admin.register(models.InfoSite)
class InfoSiteAdmin(SingleModelAdmin, TranslationAdmin):
    model = models.InfoSite
    fieldsets = (
        ('', {'fields': ('email', 'telefono','footer_inf','welcome_text','coordenadas')}),
        ('Social', {'fields': ('facebook', 'twitter','linkedin','youtube','whatsapp')}),
        ('Iconos', {'fields': ('favi57', 'favi72','favi114','favi256')}),
        ('Site/SEO', {'fields': ('site', 'titulo', 'ga')})
    )

    def has_add_permission(self, request):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

@admin.register(models.Sliders)
class Sliders(TranslationAdmin):
    list_display = ['miniatura','enlace', 'posicion', 'active']
# 	fieldsets = (
# 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# 	)
    ordering = ['posicion']

    def miniatura(self, obj):
        if obj.fondo and obj.fondo.filetype == "Image":
            return u'<img src="%s" />' % obj.fondo.version_generate(
                ADMIN_THUMBNAIL).url
        else:
            return ""

    miniatura.allow_tags = True
    miniatura.short_description = "Miniatura"

    def has_add_permission(self, request):
        if request.user.has_perm('web.Sliders'):
            num_objects = self.model.objects.count()
            if num_objects >= 6:
                return False
            else:
                return True


@admin.register(models.PorqueElegirnos)
class PorqueElegirnosAdmin(TranslationAdmin):
    model = models.PorqueElegirnos
    list_display = ['__unicode__']
    # search_fields = []
    # filter_fields = []
    # inlines = []
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    # ordering = ['posicion']

@admin.register(models.SeccionInferior)
class SeccionInferiorAdmin(SingleModelAdmin):
    model = models.SeccionInferior
    list_display = ['__unicode__']

@admin.register(models.Conocenos)
class ConocenosAdmin(SingleModelAdmin, TranslationAdmin):
    model = models.Conocenos
    list_display = ['__unicode__']
    # search_fields = []
    readonly_fields = ['bg_vid_id','cf_vid_id', 'bg_vimeo_id', 'cf_vimeo_id']
    # filter_fields = []
    # inlines = []
    fieldsets = (
        ('', {'fields': ('cabecera','img')}),
        ('Información', {'fields': ('qs','pa','ms', 'vs')}),
        ('Video Instructivo', {'fields': ('bg_titulo','bg_img','bg_vid', 'bg_vid_id','bg_vimeo', 'bg_vimeo_id')}),
        ('Cómo Funciona', {'fields': ('cf_descript','cf_img','cf_vid', 'cf_vid_id','cf_vimeo', 'cf_vimeo_id')}),
        ('Nuestro Staff', {'fields': ('ns_titulo','ns_descript')}),
        ('Nos Respaldan', {'fields': ('nr_titulo','nr_descript')})
    )
    # ordering = ['posicion']

@admin.register(models.EllosOpinan)
class EllosOpinanAdmin(TranslationAdmin):
    model = models.EllosOpinan
    list_display = ['__unicode__']
    # search_fields = []
    # filter_fields = []
    # inlines = []
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    ordering = ['posicion']

@admin.register(models.Clientes)
class ClientesAdmin(admin.ModelAdmin):
    model = models.Clientes
    list_display = ['__unicode__']
    # search_fields = []
    # filter_fields = []
    # inlines = []
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    ordering = ['posicion']

@admin.register(models.Respaldos)
class RespaldosAdmin(admin.ModelAdmin):
    model = models.Respaldos
    list_display = ['__unicode__']
    # search_fields = []
    # filter_fields = []
    # inlines = []
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    ordering = ['posicion']

@admin.register(models.Paises)
class PaisesAdmin(TranslationAdmin):
    model = models.Paises
    list_display = ['__unicode__',"active","band"]
    search_fields = ['nombre']
    # filter_fields = []
    # inlines = []
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    ordering = ["-active",'nombre']

    def band(self, obj):
        if obj.img and obj.img.filetype == "Image":
            return u'<img src="%s" />' % obj.img.version_generate(
                ADMIN_THUMBNAIL).url
        else:
            return ""

    band.allow_tags = True
    band.short_description = "Miniatura"

@admin.register(models.ContactoSeccion)
class ContactoSeccionAdmin(SingleModelAdmin, TranslationAdmin):
    model = models.ContactoSeccion

@admin.register(models.LibroSeccion)
class LibroSeccionAdmin(SingleModelAdmin, TranslationAdmin):
    model = models.LibroSeccion


##### SEO MLang #########################################
@admin.register(models.TranslaterDicc)
class TranslaterDiccAdmin(TranslationAdmin):
    model = models.TranslaterDicc
    readonly_fields = ['variable']
    list_display = ('variable', 'nombre_es','nombre_en','nombre_pt')
    search_fields = ['variable']
    list_editable = ['nombre_es','nombre_en','nombre_pt']


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
# class ClientesTestimoniosAdmin(SingleModelAdmin):
# 	model = ClientesTestimonios
# 	readonly_fields = ['nombre']
# 	inlines = [TestimoniosInline,ClientesInline]



# class NosotrosValoresInline(admin.StackedInline):
# 	model = NosotrosValores
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0


# @admin.register(Nosotros)
# class NosotrosAdmin(SingleModelAdmin):
# 	model = Nosotros
# 	inlines = [NosotrosValoresInline]
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']

# @admin.register(NosotrosValores)
# class NosotrosValoresAdmin(TranslationAdmin):
# 	model = NosotrosValores
# 	list_display = ['__unicode__']
# 	search_fields = []
# 	filter_fields = []
# 	inlines = []
# 	fieldsets = (
# 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# 	)
# 	ordering = ['posicion']


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
# class ServiciosAdmin(admin.ModelAdmin):
# 	model = Servicios
# 	inlines = [ServicioGaleryInline,ServicioTabsInline]
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']


# @admin.register(LesionesSeccion)
# class LesionesSeccionAdmin(SingleModelAdmin):
# 	model = LesionesSeccion
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']

# @admin.register(Lesiones)
# class LesionesAdmin(admin.ModelAdmin):
# 	model = Lesiones
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']

# @admin.register(ContactoSeccion)
# class ContactoSeccionAdmin(SingleModelAdmin):
# 	model = ContactoSeccion
# 	# list_display = ['__unicode__']
# # 	fieldsets = (
# # 		('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# # 	)
# 	# ordering = ['posicion']



admin.site.unregister(Group)
admin.site.unregister(Site)
