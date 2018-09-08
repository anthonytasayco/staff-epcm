# -*- coding: utf-8 -*-

from logging import getLogger

from ..web.models import InfoSite

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