# -*- coding: utf-8 -*-

from logging import getLogger
log = getLogger('django')
from django.shortcuts import render
from django.shortcuts import redirect, render_to_response, get_object_or_404
# from apps.core.util import get_query
from apps.pedidos.models import ( Pedido, DetallePedido
)

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse, reverse_lazy
from django.http import HttpResponseRedirect
from django.forms.models import model_to_dict
from django.template import RequestContext as ctx
from django.contrib import messages
from django.http import HttpResponse
from django.template.loader import get_template
from django.template import Context
from django.core.mail import EmailMessage
from django.conf import settings
from apps.web.util import get_info
global STATIC_URL, MEDIA_URL
STATIC_URL = settings.STATIC_URL
MEDIA_URL = settings.MEDIA_URL
EMAIL_DEVELOPER = settings.EMAIL_DEVELOPER


#----        dc      ------------------------
def pago_email_cliente(pedido):
    try:
        htmly = get_template('email/pago_cliente.html')
    except Exception as e:
        htmly = get_template('pedidos/correos/pago_cliente.html')
    info = get_info()
    c_d = {}
    c_d['STATIC_URL'] = (info.site + STATIC_URL)
    c_d['MEDIA_URL'] = (info.site + MEDIA_URL)
    c_d['info'] = info
    c_d['pedido'] = pedido

    # cuentas = CuentaBancaria.objects.all()
    detalle = DetallePedido.objects.filter(pedido=pedido)
    # c_d['cuentas'] = cuentas
    c_d['detalle'] = detalle

    d = Context(c_d)

    html_content = htmly.render(d)
    asunto = u'%s N°%s' % ('Gracias por su compra', pedido.codigo)
    mail = '{0}<{1}>'.format(settings.PROJECT_NAME, settings.DEFAULT_FROM_EMAIL)
    msg = EmailMessage(asunto, html_content, mail,
                       [pedido.usuario_email], EMAIL_DEVELOPER,)
    msg.content_subtype = "html"
    msg.send()


def pago_email_administrador(pedido):
    try:
        htmly = get_template('email/pago_administrador.html')
    except Exception as e:
        htmly = get_template('pedidos/correos/pago_administrador.html')

    info = get_info()
    c_d = {}
    c_d['STATIC_URL'] = (info.site + STATIC_URL)
    c_d['MEDIA_URL'] = (info.site + MEDIA_URL)
    c_d['info'] = info
    c_d['pedido'] = pedido

    # cuentas = CuentaBancaria.objects.all()
    detalle = DetallePedido.objects.filter(pedido=pedido)
    # c_d['cuentas'] = cuentas
    c_d['detalle'] = detalle

    d = Context(c_d)

    html_content = htmly.render(d)
    asunto = u'%s N°%s' % ('Pago Realizado ', pedido.codigo)
    mail = '{0}<{1}>'.format(settings.PROJECT_NAME, settings.DEFAULT_FROM_EMAIL)
    msg = EmailMessage(asunto, html_content, mail,
                       info.get_email_ventas(), EMAIL_DEVELOPER,)
    msg.content_subtype = "html"
    msg.send()


def email_expira_pagoefectivo(email):
    htmly = get_template('email/expira_pagoefectivo.html')
    cd = {}
    emailsend = email
    d = Context(cd)

    html_content = htmly.render(d)
    asunto = u'Código expirado'
    mail = '{0}<{1}>'.format(settings.PROJECT_NAME,
        settings.DEFAULT_FROM_EMAIL)
    msg = EmailMessage(asunto, html_content, mail, [emailsend])
    msg.content_subtype = "html"
    msg.send()
