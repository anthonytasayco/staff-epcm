# -*- coding: utf-8 -*-
from datetime import datetime
from logging import getLogger
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import logout_then_login
from django.core.urlresolvers import reverse, reverse_lazy
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response as render, redirect
from django.template import RequestContext as ctx
from django.http import JsonResponse
from django.http import Http404

from .forms import (EditUsuarioForm, LoginForm, RegistroForm, RecuperaPasswordForm, DireccionForm,
	SetPasswordForm)
from .models import Usuario, Direccion, Region, Provincia, Distrito

from apps.pedidos.models import Pedido, DetallePedido
from ..web.models import Paises
from ..web.templatetags.app_tags import t as transDicc
# from apps.web.models import InfoLogin
from django.forms.models import model_to_dict
from apps.web.util import get_info
from django.http import HttpResponse
from apps.pedidos.utilscart import carrito_result, carrito_get_nro, getlist_carrito
import json
from apps.custom_auth.mensajes import mensajes_auth

log = getLogger('django')

def client_only(view):
	def validador(request, *args, **kwargs):
		if hasattr(request.user, 'is_client'):
			return view(request, *args, **kwargs)
		else:
			return render('superuser-noallowed.html', locals(),
			context_instance=ctx(request))
	return validador


def valid_email(request):
	result = list()
	fieldid = request.GET.get('fieldId', '')
	fieldvalue = request.GET.get('fieldValue', '')
	users = Usuario.objects.filter(email=fieldvalue)
	if users.exists():
		result.append(fieldid)
		result.append(False)
		result.append('el email ya se encuentra registrado')
	else:
		result.append(fieldid)
		result.append(True)
		result.append('ok')
	return HttpResponse(json.dumps(result))


def valid_email_edit(request):
	result = list()
	fieldid = request.GET.get('fieldId', '')
	fieldvalue = request.GET.get('fieldValue', '')
	users = Usuario.objects.filter(email=fieldvalue)
	try:
		usuario = request.user
		users = users.exclude(pk=usuario.pk)
	except Exception as e:
		pass

	if users.exists():
		result.append(fieldid)
		result.append(False)
		result.append('el email ya se encuentra registrado')
	else:
		result.append(fieldid)
		result.append(True)
		result.append('ok')
	return HttpResponse(json.dumps(result))



def login_view(request):
	if request.user.is_authenticated():
		return redirect('custom_auth:micuenta_datos')
	# row, created = InfoAcceso.objects.get_or_create(pk=1)
	error_accesos = True
	if request.method == 'POST':
		next_url = request.POST.get('next', '')
		form = LoginForm(request.POST)
		if form.is_valid():
			user = form.auth()
			# print ufmisser
			if user is not None:
				if user.is_active:
					user.last_login = datetime.now()
					user.save()
					login(request, user)
					# mensajes_auth(request, 'login.inicio.ok')
					# messages.success(request, u'Bienvenido, Se ha registrado e iniciado sesión satisfactoriamente')
					sesioncarrito = request.session.get('sesioncarrito', '')
					next_url = request.POST.get('next', '')
					if next_url:
						return redirect(next_url)
					if sesioncarrito:
						return redirect('pedidos:carrito')
					return redirect('custom_auth:micuenta_datos')
					# return redirect('web:home')
				else:
					user_inactive = True
			else:
				error_accesos = True
				mensajes_auth(request, 'login.acceso.error')

		# return render(request, 'web/acceso/_ingresar-catalogo.html', locals())
	else:
		next_url = request.GET.get('next', '')
		form = LoginForm()

	# if error_accesos:
	#     mensajes_auth(request, 'login.acceso.error')

	# row, created = InfoLogin.objects.get_or_create(pk=1)
	meta_title = u'Login'
	# return render(request, 'web/acceso/ingresar-catalogo.html', locals())
	try:
		return render('web/iniciar-sesion.html', locals(),
			context_instance=ctx(request))
	except Exception as e:
		return render('custom_auth/login.html', locals(),
			context_instance=ctx(request))



def logout(request):
	return logout_then_login(request, reverse('custom_auth:login'))



def registro(request):
	log.info('VIEW: registro')

	# if request.user.is_authenticated():
	#     return redirect(reverse('custom_auth:myaccount'))

	nexturl = request.GET.get('next', '')
	if request.method == 'POST':
		form = RegistroForm(request.POST)

		nexturl = request.POST.get('nexturl', None)
		# print form
		if form.is_valid():
			form.save()
			user = form.auth()
			form.enviaEmail()
			login(request, user)
			mensajes_auth(request, 'login.registro.ok')
			# messages.success(request, u'Bienvenido, Se ha registrado e iniciado sesión satisfactoriamente')
			sesioncarrito = request.session.get('sesioncarrito', '')
			if sesioncarrito:
				return redirect('pedidos:carrito')

			else:
                                print(form.errors)
				return redirect('custom_auth:micuenta_datos')
		else:
                        print(form.errors)
			return redirect('custom_auth:login')
			log.warning('Error de formulario')
	else:
		form = RegistroForm()
	try:
		return render('web/registrate.html', locals(),
			context_instance=ctx(request))
	except Exception as e:
		return render('custom_auth/registro.html', locals(),
			context_instance=ctx(request))


@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def micuenta_datos(request):
	log.info('VIEW: profile')
	row = request.user
	# pedidos = Pedido.objects.filter(usuario_id=str(row.id))
	# direcciones = Direccion.objects.filter(usuario=row)
	paises = Paises.objects.all().order_by('nombre')
	if request.method == 'POST':
		print request.POST
		# print 'post post'
		form = EditUsuarioForm(request.POST)
		# print form
		if form.is_valid():
			row = form.update(row.pk)
			mensajes_auth(request, 'login.cuenta.update')
			# messages.success(request, 'Se actualizó satisfactoriamente')
			return redirect('custom_auth:micuenta_datos')
		else:
			messages.error(request, 'Formulario no valido')
			log.warning('Error de formulario')
	else:
		initial = model_to_dict(row)
		form = EditUsuarioForm(initial)
	try:
		return render('web/actualizar-datos.html', locals(),
			context_instance=ctx(request))
	except Exception as e:
		return render('custom_auth/micuenta-datos.html', locals(),
			context_instance=ctx(request))


@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def micuenta_direcciones(request):
	log.info('VIEW: addresses')
	usuario = request.user
	direcciones = Direccion.objects.filter(usuario=usuario, is_active=True).order_by('id')
	try:
		return render('web/micuenta-direcciones.html', locals(),
			context_instance=ctx(request))
	except Exception as e:
		return render('custom_auth/micuenta-direcciones.html', locals(),
			context_instance=ctx(request))



@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def micuenta_direcciones_edit(request, slug=None):
	log.info('VIEW: profile')
	nro = 1
	distrito = request.POST.get('distrito', '')# 1065)
	provincia = request.POST.get('provincia', '')#, 114)
	region = request.POST.get('region', '')#, 16)

	if slug:
		row = Direccion.objects.get(slug=slug)
		ida = row.id
	else:
		row = None
		ida = 0
	if request.method == 'POST':
		# caso cuando se seleccionó una direccion
		opc = request.POST.get('opc', '0')
		direccion = request.POST.get('direccion', '')
		if opc == '1' and direccion != '' and direccion != '0':
			request.session['tmp_dir'] = '%s' % direccion
			return redirect('pedidos:datos_facturacion')
		# caso cuando se obtiene
		form = DireccionForm(request.POST)
		# print form
		if form.is_valid():
			row = form.save(request)
			if distrito:
				distritod = Distrito.objects.get(pk=int(distrito))
				row.distrito_nombre = distritod.nombre
				row.provincia_nombre = distritod.provincia.nombre
				row.region_nombre = distritod.provincia.region.nombre
				row.save()
			# if slug:

			opc = request.POST.get('opc', '0')
			if opc == '1':
				request.session['tmp_dir'] = '%s' % row.id
				return redirect('pedidos:datos_facturacion')

			messages.success(request, 'Se actualizó satisfactoriamente')
			return redirect('custom_auth:micuenta_direcciones')

		else:
			log.warning('Error de formulario')
	else:
		if row:
			if row.distrito:
				distrito = row.distrito
				provincia = row.provincia
				region = row.region
			initial = model_to_dict(row)
			form = DireccionForm(initial)
		else:
			form = DireccionForm()
	try:
		return render('web/micuenta-direcciones-edit.html', locals(),
			context_instance=ctx(request))
	except Exception as e:
		return render('custom_auth/micuenta-direcciones-edit.html', locals(),
			context_instance=ctx(request))


@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def micuenta_direcciones_del(request, slug=None):
	log.info('VIEW: del address')
	if slug:
		row = Direccion.objects.get(slug=slug, is_active=True)
		row.is_active = False
		row.save()
	return redirect('custom_auth:micuenta_direcciones')



@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def micuenta_pedidos(request, slug=None):
	log.info('VIEW: orders')
	if slug:
		row = Pedido.objects.get(codigo=slug)
		result = DetallePedido.objects.filter(pedido=row)
		try:
			return render('web/micuenta-pedidos-detalle.html', locals(),
				context_instance=ctx(request))
		except Exception as e:
			return render('custom_auth/micuenta-pedidos-detalle.html', locals(),
				context_instance=ctx(request))
	else:
		pedidos = Pedido.objects.filter(usuario_id=request.user.id).order_by('-created')
		try:
			return render('web/mis-pedidos.html', locals(),
				context_instance=ctx(request))
		except Exception as e:
			return render('custom_auth/micuenta-pedidos.html', locals(),
				context_instance=ctx(request))


@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def micuenta_listadeseos(request):
	log.info('VIEW: listadeseos')
	usuario = request.user
	if request.method == 'POST':
		ida = request.POST.get('ida', '')
		opc = request.POST.get('opc', '')
		if opc == '1':
			fav = Favoritos.objects.get(id=int(ida))
			# ev = carrito_add_item(request, det.id, cantidad, det)
			result, suma, n, nro = carrito_result(request,'1', fav.producto.id, '1')

			request.session['tmp_add'] = '%s' % fav.producto.id
			# print result
		if opc == '2':
			Favoritos.objects.filter(id=int(ida)).delete()
			request.session['tmp_del'] = 'delete'
		return redirect('custom_auth:micuenta_listadeseos')

	tmp_add = request.session.get('tmp_add', '')
	if tmp_add != '':
		det = Producto.objects.get(id=int(tmp_add))
	else:
		det = None

	request.session['tmp_add'] = ''
	tmp_del = request.session.get('tmp_del', '')
	request.session['tmp_del'] = ''
	deseos = Favoritos.objects.filter(usuario__pk=usuario.pk)
	# direcciones = Direccion.objects.filter(usuario=usuario, is_active=True).order_by('id')
	# try:
	return render('web/micuenta-deseos.html', locals(),
		context_instance=ctx(request))
	# except Exception as e:
	#     return render('custom_auth/micuenta-direcciones.html', locals(),
	#         context_instance=ctx(request))


@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def cambiarpassword(request):
	if request.method == 'POST':
		pwd = request.POST.get('pwd',False)
		new_pwd = request.POST.get('new_pwd',False)
		new_pwd_rpt = request.POST.get('new_pwd_rpt',False)
		if new_pwd != new_pwd_rpt:
			return JsonResponse({'status':409,'msg':transDicc(u'Las contraseñas no coinciden')})

		if len(pwd) >= 7 and len(new_pwd) >= 7 and len(new_pwd_rpt) >= 7:
			if request.user.is_password_valid(pwd):
				if new_pwd != new_pwd_rpt:
					return JsonResponse({'status':409,'msg':transDicc('Las contraseñas no coinciden')})
				request.user.set_password = False
				request.user.password = new_pwd
				request.user.save()
				return JsonResponse({'status':200,'msg':transDicc(u'La contraseña de tu cuenta ha sido cambiada satisfactoriamente')})
			else:
				return JsonResponse({'status':406,'msg':transDicc(u'La contraseña actual no es valida')})
		else:
			return JsonResponse({'status':409,'msg':transDicc(u'Las contraseñas deben tener un mínimo de 7 caracteres')})
	else:
		raise Http404


def set_password(request, uuid_hash):
	log.info('VIEW: set_password')

	if request.method == 'POST':
		form = SetPasswordForm(request.POST)
		if form.is_valid():
			form.save()
			# form.enviaEmail()

			mensajes_auth(request, 'login.set_password.envio')
			# messages.success(request, u'Se ha actualizado satisfatoriamente, ahora puede iniciar sesión con la nueva contraseña')
			return HttpResponseRedirect(
				reverse('custom_auth:set_password_success'))
		else:
                        print(form.errors)
			log.warning('Error de formulario')
	else:
		try:
			user = Usuario.objects.get(uuid_hash=uuid_hash)
		except Usuario.DoesNotExist():
			user = None
		form = SetPasswordForm(initial={'email': user.email,
			'uuid_hash': uuid_hash})

	return render('custom_auth/password/set-password.html', locals(),
		context_instance=ctx(request))


def set_password_success(request):
	'''
		Pantalla mostrada al cambiar la contraseña satisfactoriamente.
		Redirecciona al Login y muestra un mensaje.
	'''
	log.info('VIEW: set_password_success')

	return redirect('custom_auth:login')


def recupera_password(request):
	log.info('VIEW: recupera_passowrd')

	if request.method == 'POST':
		form = RecuperaPasswordForm(request.POST)
		if form.is_valid():
			form.enviaEmail()
			mensajes_auth(request, 'login.recuera_password.envio')
			return redirect('custom_auth:login')

		else:
                        print(form.errors)
			log.warning('Error de formulario')
	else:
		form = RecuperaPasswordForm()

	try:
		return render('web/olvidaste-contrasenia.html', locals(),
			context_instance=ctx(request))
	except Exception as e:
		return render('custom_auth/password/recupera-password.html', locals(),
			context_instance=ctx(request))
# olvidaste-coontrasenia

# PRIVATE VIEW
@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def logged_view(request):
	log.info('VIEW: logged_view')

	return render('custom_auth/privado.html', locals(),
		context_instance=ctx(request))


# -----------------------     my addres  ----------------------------------

@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def myaccount(request):
	log.info('VIEW: addresses')
	# usuario = request.user
	# direcciones = Direccion.objects.filter(usuario=usuario)

	return render('custom_auth/micuenta.html', locals(),
		context_instance=ctx(request))



@login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def order_del(request, slug=None):
	log.info('VIEW: del order')
	if slug:
		row = Pedido.objects.get(codigo=slug)
		row.visible_x_cliente = False
		row.save()
	return redirect('custom_auth:micuenta_pedidos')
