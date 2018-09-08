# -*- coding: utf-8 -*-
from datetime import datetime
from logging import getLogger
from ratelimit.decorators import ratelimit

from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import logout_then_login
from django.core.urlresolvers import reverse, reverse_lazy
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response as render, redirect
from django.template import RequestContext as ctx

# from .forms import (EditUsuarioForm, LoginForm, RegistroForm, RecuperaPasswordForm, DireccionForm,
#     SetPasswordForm)
# from .models import Region, Provincia, Distrito
from apps.custom_auth.forms import DireccionForm, DireccionDeleteForm, RegistroForm
from apps.custom_auth.forms import (
    RegionesForm,
    ProvinciasForm,
    DistritosForm,
)
from apps.custom_auth.utils import strip_tags
from django.forms.models import model_to_dict
from apps.web.util import get_info
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json

log = getLogger('django')

@csrf_exempt
def registro(request):
    env = {}
    datos = {}
    if request.method == 'POST':
        form = RegistroForm(request.POST)
        if form.is_valid():
            form.save()
            user = form.auth()
            login(request, user)
            messages.add_message(request, messages.WARNING,
                    'Bienvenido, Se ha registrado e iniciado sesión satisfactoriamente')
            redcarrito = 'no'
            sesioncarrito = request.session.get('sesioncarrito', '')
            if sesioncarrito:
                redcarrito = 'si'
            env['error'] = 'no'
            env['redcarrito'] = redcarrito
            # env['idn'] = row.pk
            env['datos'] = datos
            # env['ida'] = row.pk
            # login_usuario(request, row)
            return HttpResponse(json.dumps(env))
        else:
            if form.errors:
                for error in form.errors:
                    e = form.errors[error]
                    datos[error] = str(e)
            othererror = '%s' % form.non_field_errors
            env['othererror'] = othererror
            env['error'] = 'si'
            env['datos'] = datos
            return HttpResponse(json.dumps(env))
    return HttpResponse(json.dumps(datos))


@csrf_exempt
def direcciones(request):
    env = {}
    datos = {}
    if request.method == 'POST':
        form = DireccionForm(request.POST)
        if form.is_valid():
            row = form.save(request)
            env['error'] = 'no'
            # env['idn'] = row.pk
            env['datos'] = datos
            env['ida'] = row.pk
            # login_usuario(request, row)
            return HttpResponse(json.dumps(env))
        else:
            if form.errors:
                for error in form.errors:
                    e = form.errors[error]
                    datos[error] = str(e)
            othererror = '%s' % form.non_field_errors
            env['othererror'] = othererror
            env['error'] = 'si'
            env['datos'] = datos
            return HttpResponse(json.dumps(env))
    return HttpResponse(json.dumps(datos))


@csrf_exempt
def direcciones_delete(request):
    env = {}
    datos = {}
    if request.method == 'POST':
        form = DireccionDeleteForm(request.POST)
        if form.is_valid():
            form.delete()
            env['error'] = 'no'
            # env['idn'] = row.pk
            env['datos'] = datos
            # login_usuario(request, row)
            return HttpResponse(json.dumps(env))
        else:
            if form.errors:
                for error in form.errors:
                    e = form.errors[error]
                    datos[error] = str(e)
            othererror = '%s' % form.non_field_errors
            env['othererror'] = othererror
            env['error'] = 'si'
            env['datos'] = datos
            return HttpResponse(json.dumps(env))
    return HttpResponse(json.dumps(datos))


@csrf_exempt
def regiones(request):
    env = {}
    result = {}
    errores = {}
    errorclean = ''
    status = 'error'
    if request.method == 'GET':
        form = RegionesForm(request.GET)
        if form.is_valid():
            status = 'ok'
            result = form.result()
            # form.enviaEmail()
            # env['idn'] = row.pk
            # login_usuario(request, row)
        else:
            status = 'error'
            if form.errors:
                for error in form.errors:
                    e = strip_tags(form.errors[error])
                    errores[error] = str(e)
    env['result'] = result
    env['error'] = errores
    env['status'] = status
    return HttpResponse(json.dumps(env))


@csrf_exempt
def provincias(request):
    env = {}
    result = {}
    errores = {}
    errorclean = ''
    status = 'error'
    if request.method == 'GET':
        form = ProvinciasForm(request.GET)
        if form.is_valid():
            status = 'ok'
            result = form.result()
            # form.enviaEmail()
            # env['idn'] = row.pk
            # login_usuario(request, row)
        else:
            status = 'error'
            if form.errors:
                for error in form.errors:
                    e = strip_tags(form.errors[error])
                    errores[error] = str(e)
    env['result'] = result
    env['error'] = errores
    env['status'] = status
    return HttpResponse(json.dumps(env))


@csrf_exempt
def distritos(request):
    env = {}
    result = {}
    errores = {}
    errorclean = ''
    status = 'error'
    if request.method == 'GET':
        form = DistritosForm(request.GET)
        if form.is_valid():
            status = 'ok'
            result = form.result()
            # form.enviaEmail()
            # env['idn'] = row.pk
            # login_usuario(request, row)
        else:
            status = 'error'
            if form.errors:
                for error in form.errors:
                    e = strip_tags(form.errors[error])
                    errores[error] = str(e)
    env['result'] = result
    env['error'] = errores
    env['status'] = status
    return HttpResponse(json.dumps(env))
