from django.conf.urls import patterns, url
from django.views.generic import TemplateView,RedirectView

# from django.views.generic.base import RedirectView

from django.conf import settings
# from .sitemaps import sitemaps, sitemap_view

urlpatterns = patterns('apps.formularios.views',
    # FRONT - END
    # url(r'^boletines/$', 'boletines', name='boletines'),
    url(r'^contacto_enviado/$', 'contacto_ok', name='contacto_enviado'),
    url(r'^libro-de-reclamaciones/$', 'librec', name='librec'),
    url(r'^suscript/$', 'suscript', name='suscript'),
    url(r'^curso/(?P<slug>[-\w]+)/$', 'curso', name='curso'),
    url(r'^contacto/$', 'contacto', name='contacto'),
)