# -*- coding: utf-8 -*-
from django.template.defaultfilters import safe
from django import template
from ..models import SEOTags
from django.core.urlresolvers import resolve
from django.conf import settings
from django.utils.translation import get_language, activate
from django.core.cache import cache
# from apps.web import choices

register = template.Library()

@register.filter
def registerURL4SEO(new_url=''):
	seoURL, created = SEOTags.objects.get_or_create(url_seo=new_url.split('?')[0])
	return ""

@register.filter
def getSEOTags(url_path='',custom_title=False):
	# print url_path
	seoURL = SEOTags.objects.filter(url_seo=url_path).first()
	try:
		if seoURL:
			print "Find URL full"
			if seoURL.title == "":
				if custom_title:
					if custom_title == "Verify":
						return False
					return safe(u'<title>{0}</title>'.format(custom_title,))
				else:
					return safe(u'<title>{0} | {1}</title>'.format(settings.PROJECT_NAME.title(),str(resolve(url_path.split('?')[0]).url_name)))
			return safe(u'<title>{0}</title><meta name="description" content="{1}" />{2}'.format(seoURL.title,
						seoURL.descript,seoURL.extend))
		else:
			seoURL = SEOTags.objects.filter(url_seo=url_path.split('?')[0]).first()
			if seoURL:
				print "Find URL wo Get params"
				if seoURL.title == "":
					if custom_title:
						if custom_title == "Verify":
							return False
						return safe(u'<title>{0}</title>'.format(custom_title,))
					else:
						return safe(u'<title>{0} | {1}</title>'.format(settings.PROJECT_NAME.title(),str(resolve(url_path.split('?')[0]).url_name)))
				return safe(u'<title>{0}</title><meta name="description" content="{1}" />{2}'.format(seoURL.title,
							seoURL.descript,seoURL.extend))
			else:
				print "No Found URL"
				return safe(u'<title>{0}</title>'.format(settings.PROJECT_NAME,))		
	except:
		return safe(u'<title>{0}</title>'.format(settings.PROJECT_NAME,))