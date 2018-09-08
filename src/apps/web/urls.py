from django.conf.urls import patterns, url
from django.views.generic import TemplateView,RedirectView

# from django.views.generic.base import RedirectView

from .views import RobotsView
from django.conf import settings
# from .sitemaps import sitemaps, sitemap_view
from django.utils.translation import ugettext_lazy as _

urlpatterns = patterns('apps.web.views',
    # FRONT - END
    url(r'^$', 'home', name='home'),
    url(_(r'^conocenos/$'), 'conocenos', name='conocenos'),
    url(_(r'^libro-de-reclamaciones/$'), 'librec', name='librec'),
    url(_(r'^contacto/$'), 'contacto', name='contacto'),
    url(r'^contacto_enviado/$', 'contacto_ok', name='contacto_enviado'),
    url(r'^suscript_enviado/$', 'contacto_ok', name='suscript_enviado'),
    url(r'^reclamo_enviado/$', 'contacto_ok', name='reclamo_enviado'),
    # # url(r'^bm/(?P<id>[\d]+)/$', 'test', name='test'),
    # # url(r'^b/(?P<slug>[-\w]+)/$', 'test', name='test'),
    ## Redes Apis
    url(r'^api_blog/$', 'api_blog', name='api_blog'),
    # EXTRA
    url(r'^robots\.txt$', RobotsView.as_view(), name='robots'),
    url(r'^(?P<slug>[-\w]+)\.html$', 'base_template', {'template_name': 'web/'}, name="template_file"),
    url(r'^blocks/(?P<slug>[-\w]+)\.html$', 'base_template', {'template_name': 'web/blocks/'}, name="template_blocks"),
)

# EXTRA
urlpatterns = urlpatterns + patterns('',
    url(r'^humans\.txt$',
        RobotsView.as_view(template_name='extra/humans.txt',
        content_type='text/plain; charset=utf-8'), name='humans'),
    
    url(r'^sitemap\.xml$',
        TemplateView.as_view(template_name='extra/sitemap.xml',
        content_type='application/xml')),
)
