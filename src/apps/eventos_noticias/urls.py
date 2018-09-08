from django.conf.urls import patterns, url
from django.views.generic import TemplateView,RedirectView

# from django.views.generic.base import RedirectView
from django.utils.translation import ugettext_lazy as _

# from .views import RobotsView
from django.conf import settings
# from .sitemaps import sitemaps, sitemap_view

urlpatterns = patterns('apps.eventos_noticias.views',
    # FRONT - END
    url(_(r'^eventos/$'), 'eventos', name='eventos'),
    url(_(r'^noticias/$'), 'noticias', name='noticias'),
    url(_(r'^evento/(?P<slug>[-\w]+)/$'), 'evento', name='evento'),
    url(_(r'^noticia/(?P<slug>[-\w]+)/$'), 'noticia', name='noticia'),
    # # url(r'^bm/(?P<id>[\d]+)/$', 'test', name='test'),
    # # url(r'^b/(?P<slug>[-\w]+)/$', 'test', name='test'),
    # EXTRA

)