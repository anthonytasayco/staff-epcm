# -*- coding: utf-8 -*-
from django.http import Http404
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.core.urlresolvers import reverse, resolve

def listMailClean(str_mailList):
	arr_rspn = []
	for row in str_mailList.split(','):
		arr_rspn.append(row.strip())
	return arr_rspn

def form_verify(view):
	def validador(request, *args, **kwargs):
		if request.method == 'POST':
			valid_key = request.POST.get('csrfmiddlewaretoken','')[2:69:3]
			if request.POST.get('xseg_form') == valid_key:
				email_fake = request.POST.get('email')
				if email_fake == '':
					request.POST = request.POST.copy()
					email_real = request.POST.get('correo',False)
					request.POST['email'] = email_real
					return view(request, *args, **kwargs)
			return redirect('contacto_enviado')
		else:
			raise Http404
	return validador