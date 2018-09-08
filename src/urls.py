# -*- coding: utf-8 -*-

from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.conf import settings
from django.conf.urls.i18n import i18n_patterns

from filebrowser.sites import site
from ckeditor_uploader import urls as ckeditor_uploader_urls
from admin_honeypot import urls as admin_honeypot_urls
from django.views.generic import TemplateView,RedirectView
from smart_selects import urls as smart_selects_urls
from apps.web import urls as web_urls
from apps.formularios import urls as formularios_urls
admin.autodiscover()
ADMIN_URL = settings.ADMIN_URL
import django
url_icon = '{0}icon.png'.format(settings.STATIC_URL)

urlpatterns = patterns('',
    # Redirects
    url(r'^{0}/web/infosite/$'.format(settings.ADMIN_URL), RedirectView.as_view(url='1/')),
    url(r'^ckeditor/', include(ckeditor_uploader_urls)),
    url(r'^admin/', include(admin_honeypot_urls, namespace='admin_honeypot')),
    url(r'^grappelli/', include('grappelli.urls')),
    url(r'^{0}/filebrowser/'.format(ADMIN_URL), include(site.urls)),
    # STATIC / MEDIA
    url(r'^static/(?P<path>.*)$', django.views.static.serve,
        {'document_root': settings.STATIC_ROOT}),
    url(r'^media/(?P<path>.*)$', django.views.static.serve,
        {'document_root': settings.MEDIA_ROOT}),
    url(r'^{0}/'.format(ADMIN_URL), include(admin.site.urls)),
    # WEB
    url(r'^chaining/', include(smart_selects_urls)),
    # url(r'^paypal/', include('paypal.standard.pdt.urls')),
    # url(r'^api-token-auth/', 'jwt_auth.views.obtain_jwt_token'),
    # EXTRA
    url(r'^favicon\.ico$', RedirectView.as_view(
        url=url_icon),
        name='favicon.ico'),
)

urlpatterns += i18n_patterns('',
    url(r'', include('apps.web.urls')),
    url(r'', include('apps.eventos_noticias.urls', namespace='notivent')),
    url(r'', include('apps.terminos_preguntas.urls', namespace='termpreg')),
    url(r'', include('apps.cursos.urls', namespace='cursos')),
    url(r'', include('apps.custom_auth.urls', namespace='custom_auth')),
    url(r'', include('apps.pedidos.urls', namespace='pedidos')),
    url(r'forms/', include(formularios_urls, namespace='forms')),
)


handler404 = 'apps.web.views.page_404'
handler500 = 'apps.web.views.page_500'
