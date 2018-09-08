# encoding: utf-8

from django.contrib.sitemaps import Sitemap
from django.contrib.sitemaps import views as sitemap_view
from django.views.decorators.cache import cache_page


class StaticSitemap(Sitemap):
    priority = 0.5
    lastmod = None

    def items(self):
        return [("/", "daily"),
                "/contacto"]

    def location(self, obj):
        return obj[0] if isinstance(obj, tuple) else obj

    def changefreq(self, obj):
        return obj[1] if isinstance(obj, tuple) else "monthly"

sitemaps = dict(static=StaticSitemap,
                )

sitemap_view = cache_page(86400)(sitemap_view.sitemap)
