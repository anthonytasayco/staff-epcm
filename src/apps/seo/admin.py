# -*- coding: utf-8 -*-
from django.conf import settings
from django.contrib import admin
from django.contrib.sites.models import Site
from django.contrib.auth.models import Group

from .models import (URLRegister, SEOTags, SEORedirects, InfoSeo)
from singlemodeladmin import SingleModelAdmin

STATIC_URL = settings.STATIC_URL

seo_link = [
	'{0}js/SEOLink.js'.format(STATIC_URL)
]

##### SEO MLang #########################################
@admin.register(InfoSeo)
class InfoSeoAdmin(SingleModelAdmin):
	pass
	def has_add_permission(self, request):
		return False

	def has_delete_permission(self, request, obj=None):
		return False


@admin.register(URLRegister)
class URLRegisterAdmin(admin.ModelAdmin):
	model = URLRegister
	list_display = ['url']
	readonly_fields = ['url']
	search_fields = ('url',)

	class Media:
		js = seo_link



@admin.register(SEOTags)
class SEOTagsAdmin(admin.ModelAdmin):
	model = SEOTags
	list_display = ['__unicode__', 'title', 'descript','created','modified']
	list_editable = ['title', 'descript']
	readonly_fields = ['url_seo']

	class Media:
		js = seo_link



@admin.register(SEORedirects)
class SEORedirectsAdmin(admin.ModelAdmin):
	model = SEORedirects
	list_display = ['__unicode__', 'url_out','created','modified']
	list_editable = ['url_out']

	class Media:
		js = seo_link