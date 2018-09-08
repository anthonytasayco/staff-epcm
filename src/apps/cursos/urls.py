from django.conf.urls import patterns, url
from django.views.generic import TemplateView,RedirectView

# from django.views.generic.base import RedirectView
from django.utils.translation import ugettext_lazy as _

# from .views import RobotsView
from django.conf import settings
# from .sitemaps import sitemaps, sitemap_view

urlpatterns = patterns('apps.cursos.views',
    # FRONT - END
    url(_(r'^cursos/(?P<slug>[-\w]+)/$'), 'cursos', name='cursos'),
    url(_(r'^curso/(?P<slug>[-\w]+)/$'), 'curso', name='curso'),
)