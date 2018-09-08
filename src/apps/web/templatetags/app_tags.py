# -*- coding: utf-8 -*-

import re
from django.template.defaultfilters import safe, slugify
from django import template
from apps.web.util import get_info
from django.core.urlresolvers import reverse, resolve
from django.conf import settings
from django.utils.translation import get_language, activate
from django.core.cache import cache
from ..models import TranslaterDicc
from apps.cursos.models import CursosCategorias
import urlparse

from ..util import hasherStr

register = template.Library()

# HEADER
@register.inclusion_tag('common/_header.html', takes_context = True)
def header(context):
	info = get_info()
	STATIC_URL = settings.STATIC_URL
	request = context['request']
	sesioncarrito = request.session.get('sesioncarrito', '')
	if sesioncarrito == '':
		num_cart = 0
	else:
		num_cart = len(sesioncarrito)
	langs = ['es','en','pt']
	cats = CursosCategorias.objects.active().order_by('posicion')
	return locals()


# FOOTER
@register.inclusion_tag('common/_footer.html', takes_context = True)
def footer(context):
	info = get_info()
	request = context['request']
	STATIC_URL = settings.STATIC_URL
	cats = CursosCategorias.objects.active().order_by('posicion')

	return locals()

@register.filter
def key_constructor(csrf):
	""" creaun key valido para el envio post """
	return csrf[2:69:3]

@register.filter
def split_title(txt,num):
	spt1 = txt[:num]
	spt2 = txt[num:]
	return safe(u'{0} <strong>{1}</strong>'.format(spt1,spt2))

@register.filter
def renderIStr(txt):
	splt = txt.split('//')
	counter = 0
	response = u''
	for row in splt:
		if counter == 0:
			response += u'<i>{0}</i>'.format(row,)
		elif counter ==1:
			response += u'<strong>{0}</strong>'.format(row,)
		counter += 1

	return safe(response)


@register.filter
def t(txt='',lang=''):
	cache_txt = cache.get(hasherStr(txt)+get_language(), False)
	if cache_txt:
		# print("Cache Text from {0}".format(hasherStr(txt)+get_language()))
		return safe(cache_txt)
	else:
		t = TranslaterDicc.objects.filter(variable=txt)
		if t:
			t = t[0]
		else :
			t = TranslaterDicc(variable=txt,nombre=txt)
			t.save()
		if t.nombre == '':
			t.nombre = txt
			t.save()
		print("Caching in {0}".format(hasherStr(txt)+get_language()))
		cache.set(hasherStr(txt)+get_language(),t.nombre, 60*60*4)

	return safe(t.nombre)


@register.filter
def tel(txt):
	""" Extrae los caracteres númericos de un teléfono """
	lista = re.findall('\d+', txt)
	telefono = ''.join(lista)
	return telefono

@register.filter
def safeStrong(texto):
	text_to_response = ""
	for row in texto:
		if row == "<":
			row = "<strong>"
		elif row == ">":
			row = "</strong>"
		text_to_response += row
	return safe(text_to_response)

@register.simple_tag(takes_context=True)
def change_lang(context, lang=None, *args, **kwargs):
	"""
	Get active page's url by a specified language
	Usage: {% change_lang 'en' %}
	"""
	try:
		path = context['request'].path
		url_parts = resolve( path )

		url = path
		cur_language = get_language()
		try:
			activate(lang)
			url = reverse( url_parts.view_name, kwargs=url_parts.kwargs )
		finally:
			activate(cur_language)
		return "%s" % url
	except:
		return "/"


@register.filter
def get_range( value ):
	return range( int(value) )



@register.filter
def linkEmails(str_to_process, joiner=' / '):
	array_to_process = str_to_process.split(',')
	array_to_response = []
	for row in array_to_process:
		array_to_response.append('<a href="mailto:{0}">{0}</a>'.format(row.strip(),))
	return safe(joiner.join(array_to_response,))

@register.filter
def html_tel(phones, joiner=' / '):
	array_to_process = phones.split(',')
	array_to_response = []
	for row in array_to_process:
		array_to_response.append('<a href="tel:{0}">{1}</a>'.format(tel(row),row.strip()))
	return safe(joiner.join(array_to_response,))


@register.filter
def linker(link):
	if link.startswith("http"):
		return safe(u'href="{0}" target="_blank"'.format(link,))
	elif link != "":
		return safe(u'href="/{1}{0}"'.format(link,get_language()))
	else:
		return safe('style="cursor:pointer;"')


@register.filter
def safeStrong(texto):
	text_to_response = ""
	for row in texto:
		if row == "<":
			row = "<strong>"
		elif row == ">":
			row = "</strong>"
		text_to_response += row
	return safe(text_to_response)


@register.filter
def safeSpan(texto):
	text_to_response = ""
	for row in texto:
		if row == "<":
			row = "<span>"
		elif row == ">":
			row = "</span>"
		text_to_response += row
	return safe(text_to_response)


@register.filter
def liList(lista):
	list_html = ''
	lista = lista.split(',')
	for row in lista:
		list_html += "<li>{0}</li>".format(row.strip(),)
	return safe(list_html)


@register.filter
def slashBr(text):
	return safe(text.replace("//","</br>"))

@register.filter
def yt_id(url):
	url_data = urlparse.urlparse(url)
	query = urlparse.parse_qs(url_data.query)
	try:
		video = query['v'][0]
	except IndexError:
		video = None
	except KeyError:
		video = None
	return video

@register.filter
def comadecimal(nro=None):
    if not nro:
        return ''
    nro = float(nro)
    decimal = '%s'% (int(nro*100)%100)
    value = int(nro)
    value = intcomma(value)
    value = value.replace('.', ',')
    newdecimal = decimal.rjust(2, '0')
    # if decimal != '0':
    return '%s.%s' % (value, newdecimal)