# -*- coding: utf-8 -*-
from logging import getLogger
from .models import InfoSite

from django.conf import settings
from django.utils.translation import get_language
from django.core.cache import cache
import hashlib

log = getLogger('django')

def get_info():
	# Obtiene o crea una instancia de InfoSite en caso de que no exista.

	info = InfoSite.objects.all()
	if info:
		return info[0]
	else:
		info = InfoSite(email='chevarrias@gmail.com',
			telefono='5555555', direccion='Av. Sin Nombre #123',
			facebook='http://facebook.com/', site='http://127.0.0.1:8000')
		info.save()
		return info

def get_coors():
	import random, decimal
	num_1_min = -11.942884
	num_1_max = -12.112792
	num_2_min = -76.835941
	num_2_max = -77.042962
	return str(round(random.random()*(num_1_min-num_1_max)+num_1_max, 12))+","+str(round(random.random()*(num_2_min-num_2_max)+num_2_max, 12))


def setInfoSite(request):
	# print ">>>>>>>>>>>>>>>>>>>> Template Proccessor <<<<<<<<<<<<<<<<<"
	try:
		MAP_KEY = settings.GEOPOSITION_GOOGLE_MAPS_API_KEY
		GOOGLE_APIKEY = u'&key={0}'.format(MAP_KEY,)
	except:
		GOOGLE_APIKEY = '&sensor=false'
		
	if request.is_secure():
		http_protocol = "https://"
	else:
		http_protocol = "http://"
	base_url = '{0}{1}'.format(http_protocol, request.get_host())
	url_canonical = '{0}{1}{2}'.format(http_protocol, request.get_host(),request.path)
	return {'info':get_info(),'base_url':base_url,'uri_canonical':url_canonical,'GOOGLE_APIKEY':GOOGLE_APIKEY}



def hasherStr(texto):
	hash_object = hashlib.sha1(texto.encode('utf-8'))
	hex_dig = hash_object.hexdigest()
	return str(hex_dig)[10:35:2]