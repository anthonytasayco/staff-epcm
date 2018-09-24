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


@admin.register(models.CursosDeInteres)
class CursosDeInteresAdmin(SingleModelAdmin,TranslationAdmin):
    model = models.CursosDeInteres

@admin.register(models.Rubros)
class RubrosAdmin(TranslationAdmin):
    model = models.Rubros
    list_display = ['__unicode__','categorias']
    # filter_horizontal = ['relacion']
    ordering = ['posicion']

    def categorias(self,obj=None):
        arr = []
        for row in obj.categoria.all():
            arr.append(row.nombre)
        return u', '.join(arr,)

@admin.register(models.Idiomas)
class IdiomasAdmin(TranslationAdmin):
    model = models.Idiomas
    list_display = ['__unicode__','categorias']
# 	# search_fields = []
# 	# filter_fields = []
# 	# inlines = []
# 	# fieldsets = (
# 	# 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# 	# )
    ordering = ['posicion']

    def categorias(self,obj=None):
        arr = []
        for row in obj.categoria.all():
            arr.append(row.nombre)
        return u', '.join(arr,)


# class RubrosInline(TranslationTabularInline):
# 	model = models.Rubros
# 	sortable_field_name = 'posicion'
# 	ordering = ['posicion']
# 	extra = 0

@admin.register(models.CursosCategorias)
class CursosCategoriasAdmin(TranslationAdmin):
    model = models.CursosCategorias
    list_display = ['__unicode__','categorias']
    # search_fields = []
    # filter_fields = []
    # inlines = [RubrosInline]
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    # filter_horizontal = ('rubros','idiomas')
    ordering = ['posicion']

    def categorias(self, obj):
        arr = []

        for row in obj.getRubros():
            arr.append(row.nombre)

        return ', '.join(arr,)

class ContenidosInline(TranslationTabularInline):
    model = models.Contenidos
    sortable_field_name = 'posicion'
    ordering = ['posicion']
    extra = 0

class BeneficiosInline(TranslationTabularInline):
    model = models.Beneficios
    sortable_field_name = 'posicion'
    ordering = ['posicion']
    extra = 0

@admin.register(models.Cursos)
class CursosAdmin(TranslationAdmin):
    model = models.Cursos
    list_display = ['__unicode__','categoria','nuevo','online','classroom',
                    'webcast','precio','rubros','langs']
    # search_fields = []
    readonly_fields = ['video_id','vimeo_id','dm_video_id','slug']
    # filter_fields = []
    inlines = [ContenidosInline,BeneficiosInline]
    fieldsets = (
        ('Código Promoción', {'fields': ('token', )}),
        ('Información General', {'fields': ('active','relacion','categoria','rubro', 'idiomas','posicion', 'nombre','slug', 'img')}),
        ('Categorización', {'fields': ('de_interes','nuevo','online','classroom', 'webcast')}),
        ('Información', {'fields': ('inicio','descript','yt_img_usage','video', 'video_id', 'vimeo', 'vimeo_id', 'archivo', 'fechas', 'horarios', 'lugar', 'inversion')}),
        ('Meotodología', {'fields': ('mt_show','mt_titulo','mt_descript')}),
        ('Docentes', {'fields': ('dc_titulo','dc_descript')}),
        ('Inversión', {'fields': ('iv_show','iv_descript','iv_tabla','iv_descript_pie')}),
        ('Demo Quiz', {'fields': ('dm_show','dm_titulo','dm_descript','dm_video','dm_video_id')}),
        ('Pay Info', {'fields': ('cod','precio')})
    )
    # filter_horizontal = ('rubro','idiomas')
    ordering = ['posicion']

    def rubros(self, obj):
        arr = []
        for row in obj.rubro.all():
            arr.append(row.nombre)

        return ', '.join(arr,)

    def langs(self, obj):
        arr = []
        for row in obj.idiomas.all():
            arr.append(row.nombre)
        return ', '.join(arr,)

# @admin.register(models.Contenidos)
# class ContenidosAdmin(TranslationAdmin):
# 	model = models.Contenidos
# 	list_display = ['__unicode__']
# 	# search_fields = []
# 	# filter_fields = []
# 	# inlines = []
# 	# fieldsets = (
# 	# 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# 	# )
# 	# ordering = ['posicion']

# @admin.register(models.Beneficios)
# class BeneficiosAdmin(TranslationAdmin):
# 	model = models.Beneficios
# 	list_display = ['__unicode__']
# 	# search_fields = []
# 	# filter_fields = []
# 	# inlines = []
# 	# fieldsets = (
# 	# 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# 	# )
# 	# ordering = ['posicion']

# @admin.register(models.TablaInversion)
# class TablaInversionAdmin(TranslationAdmin):
# 	model = models.TablaInversion
# 	list_display = ['__unicode__']
# 	# search_fields = []
# 	# filter_fields = []
# 	# inlines = []
# 	# fieldsets = (
# 	# 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
# 	# )
# 	# ordering = ['posicion']

@admin.register(models.Profesores)
class ProfesoresAdmin(TranslationAdmin):
    model = models.Profesores
    list_display = ['__unicode__']
    # search_fields = []
    # filter_fields = []
    # inlines = []
    # fieldsets = (
    # 	('Información', {'fields': ('active','posicion','titulo', 'descript', 'enlace', 'enlace_text')}),
    # )
    filter_horizontal = ('cursos',)
    ordering = ['posicion']
