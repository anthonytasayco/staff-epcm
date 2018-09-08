from __future__ import unicode_literals

from django import http
from django.conf import settings
from .models import SEORedirects, URLRegister, InfoSeo
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)

from logging import getLogger
from django.core.mail import EmailMessage
from django.template.loader import get_template
from django.template import Context
import threading

log = getLogger('django')

def get_info():
	m,c = InfoSeo.objects.get_or_create(pk=1)
	return m

class RedirectFallbackMiddleware(object):
	# Defined as class-level attributes to be subclassing-friendly.
	response_gone_class = http.HttpResponseGone
	response_redirect_class = http.HttpResponsePermanentRedirect

	def process_response(self, request, response):
		# No need to check for a redirect for non-404 responses.
		# print response
		if response.status_code != 404:
			return response

		full_path = request.get_full_path()
		if full_path != '/':
			r = None
			try:
				url_to_fix = URLRegister.objects.filter(url=full_path)
				if url_to_fix:
					r, created = SEORedirects.objects.get_or_create(url_in=full_path)
					if created:
						r.url_out = "/es/"
						r.save()
						threading.Thread(target=self.enviaEmail, args=(request,)).start()
						# self.enviaEmail(request)
				else:
					r = SEORedirects.objects.get(url_in=full_path,active=True)
			except SEORedirects.DoesNotExist:
				pass

			if settings.APPEND_SLASH and not request.path.endswith('/'):
				# Try appending a trailing slash.
				path_len = len(request.path)
				full_path = full_path[:path_len] + '/' + full_path[path_len:]
				try:
					r = SEORedirects.objects.get(url_in=full_path, active=True)
				except SEORedirects.DoesNotExist:
					pass

			if r:
				if r.url_out == '':
					return self.response_gone_class()
				if r.code_type == 302:
					return redirect(r.url_out)
				if r.code_type == 301:
					return self.response_redirect_class(r.url_out)
				else:
					response.status_code = r.code_type
			return response
		return response

	def enviaEmail(self,rqst):
		try:
			info = get_info()
			url_exist = SEORedirects.objects.get(url_in=rqst.get_full_path())
			if url_exist and info.seo_alerts == True and len(info.array_mails_support()) >= 1:
				log.info('RedirectFallbackMiddleware: Sending Mail | FixURL')
				htmly = get_template('seo/seo_alert.html')
				# info = get_info()
				c_d = {}
				c_d['info'] = info
				c_d['request'] = rqst
				http_protocol = str(rqst.build_absolute_uri()).split(':')[0]
				c_d['admin_url'] = "{0}://{1}/{2}/".format(http_protocol,rqst.get_host(),settings.ADMIN_URL)
				d = Context(c_d)

				html_content = htmly.render(d)
				asunto = u'{0}: Error en URL {1}'.format(settings.PROJECT_NAME.upper(),rqst.build_absolute_uri())
				mail = u'{1}<{0}>'.format(settings.DEFAULT_FROM_EMAIL,settings.PROJECT_NAME)

				msg = EmailMessage(asunto, html_content, mail, info.array_mails_support())
				msg.content_subtype = "html"
				msg.send()
			else:
				log.info('RedirectFallbackMiddleware: Envio de errores inhabilitado')
		except Exception, e:
			log.info(e)
			pass