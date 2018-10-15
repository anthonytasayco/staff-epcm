# -*- coding: utf-8 -*-
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from logging import getLogger
from decimal import Decimal
import os
from django.http import Http404
from django.http import JsonResponse
import requests
import time
from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import logout_then_login
from django.core.urlresolvers import reverse, reverse_lazy
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response as render
from django.shortcuts import redirect, get_object_or_404
from django.template import RequestContext as ctx
from django.conf import settings
from suds.client import Client
from apps.pedidos.utilspedido import equivalencia_payu
from apps.pedidos.correos import (
    pago_email_cliente, pago_email_administrador,
    email_expira_pagoefectivo)
from logging import getLogger
from apps.custom_auth.models import Usuario, Direccion, Region, Provincia, Distrito
from ..web.models import Paises

from apps.pedidos.models import (Pedido, DetallePedido,
                                CodigosDeDescuento,PaypalInfo,
                                PagoEfectivoData
                                #  PayuResponse,
                                  )
from apps.cursos.models import Cursos
from django.forms.models import model_to_dict
from apps.web.util import get_info
from django.http import HttpResponse
from apps.pedidos.forms import DatosPedidoForm, DatosPagoForm, enviaEmail as enviarCarrito
from apps.pedidos.utilscart import carrito_result, carrito_get_nro, getlist_carrito, close_carrito
from apps.pedidos.utilspedido import obtenerpedido
from ratelimit.decorators import ratelimit

from django.views.decorators.csrf import csrf_exempt
from hashlib import sha512, md5
from apps.custom_auth.mensajes import mensajes_auth
import json

from paypal.standard.forms import PayPalPaymentsForm
from paypal.standard.pdt.views import process_pdt as wCheckPDT
from .forms import PagoEfectivoForm, UpdatePedidoForm

import threading
import struct

import sys
import getopt

log = getLogger('django')


def getPercent(monto,porcentaje):
    monto = Decimal(monto)
    if porcentaje < 100:
        return monto - (monto*(porcentaje/Decimal(100.000000)))
    return 0

#
#
# def producto(request, slug=None):
#     log.info('VIEW: soluciones')
#     # row, created = Contenidos.objects.get_or_create(pk=1)
#     # soluciones = Solucion.objects.all().order_by('position')
#     ms = 'productos'
#     if not slug:
#         return redirect('web:home')
#     det = get_object_or_404(Producto, slug=slug)
#     det.visitas = det.visitas + 1
#     det.save()
#     marca = det.marca
#     categoria = det.categoria
#
#     instance_user = isinstance(request.user, Usuario)
#     if instance_user:
#         usuario = request.user
#     else:
#         usuario = None
#     if request.method == 'POST':
#         cantidad = request.POST.get('cantidad', '')
#         if cantidad:
#             # ev = carrito_add_item(request, det.id, cantidad, det)
#             result, suma, n, nro = carrito_result(request,'1', det.id, cantidad)
#             try:
#                 importe = float(cantidad)*float(det.precio)
#             except Exception as e:
#                 importe = 0
#             request.session['tmp_add'] = '%s' % importe
#             # print result
#         return redirect('pedidos:productos_detalle', slug=det.slug)
#     deseosid = request.GET.get('d', '')
#     if deseosid != '':
#         # print 'reinicio'
#         if usuario:
#             favorito = Favoritos.objects.get_or_create(usuario=usuario, producto=det)
#             mensajes_auth(request, 'cuenta.deseos.add')
#         return redirect('pedidos:productos_detalle', slug=det.slug)
#
#     tmp_add = request.session.get('tmp_add', '')
#     request.session['tmp_add'] = ''
#     buscados = Producto.objects.filter(active=True).order_by('-visitas')[:10]
#     destacados = Producto.objects.filter(active=True, destacado=True, marca=marca).order_by('?')[:10]
#
#     galeria = Galeria.objects.filter(producto=det).order_by('position')
#     especificaciones = Especificaciones.objects.filter(producto=det).order_by('position')
#     caracteristicasp = Caracteristica.objects.filter(producto=det).order_by('position')
#
#     items = MarcaCategoriaGaleria.objects.filter(categoria=categoria, marca=marca)
#     if items.exists():
#         marcacategoria = items[0]
#     # return render(request, 'web/producto.html', locals(),
#     #     context_instance=ctx(request))
#     return render('web/producto.html', locals(),
#         context_instance=ctx(request))
#
def client_only(view):
    def validador(request, *args, **kwargs):
        if request.user.is_authenticated():
            if hasattr(request.user, 'is_client'):
                return view(request, *args, **kwargs)
            else:
                return render('superuser-noallowed.html', locals(),
                context_instance=ctx(request))
        return view(request, *args, **kwargs)
    return validador


@ratelimit(key='user_or_ip', rate='20/h', method=ratelimit.UNSAFE)
@client_only
def setDescuento(request):
    if request.method == 'POST':
        was_limited = getattr(request, 'limited', False)
        if was_limited:
            return JsonResponse({'status':401}, safe=True)
        codigo = CodigosDeDescuento.objects.filter(
                    cod=request.POST.get('cod_dsct','_____________')).order_by('-ini').first()
        print(codigo, 'CODIGO')
        if codigo:
            if codigo.is_valid:
                request.session['dscnt'] = codigo.id
                request.session['dscnt_cod'] = codigo.cod
                return JsonResponse({'status':202}, safe=True)
            else:
                return JsonResponse({'status':423}, safe=True)
        else:
            return JsonResponse({'status':406}, safe=True)
    else:
        raise Http404


@client_only
def carrito(request):
    partial = request.GET.get('partial', '')
    if partial != '':
        opc = request.GET.get('opc', '0')
        ida = request.GET.get('ida', '0')
        can = request.GET.get('can', '0')
        result, suma, n, nro = carrito_result(request, opc, ida, can)
        if suma == 0:
            descuento = 0
            request.session['dscnt'] = 0
            request.session['dscnt_cod'] = ''
        descuento = request.session.get('dscnt', 0)
        if descuento > 0:
            descuento = CodigosDeDescuento.objects.get(id=descuento).pct
            suma = getPercent(suma, descuento)
        return render('web/_producto-elegido.html', locals(),
                      context_instance=ctx(request))
    else:
        result, suma, n, nro = carrito_result(request, 0)
        print(suma, 'SUMAAAAAAAAA!')
        if suma == 0:
            close_carrito(request)
            request.session['dscnt'] = 0
            request.session['dscnt_cod'] = ''
        print(request.session.get('dscnt'), 'ID DESCUENTO')
        descuento = request.session.get('dscnt', 0)
        if descuento > 0:
            descuento = CodigosDeDescuento.objects.get(id=descuento).pct
            suma = getPercent(suma, descuento)
        return render('web/producto-elegido.html', locals(),
                      context_instance=ctx(request))


def promotion(request, token=None):
    data = {'status': 'Error'}
    course = get_object_or_404(Cursos, token=token)

    carrito_result(request, '1', course.id, 1)

    data['status'] = 'OK'
    if request.user.is_authenticated():
        return redirect('pedidos:carrito')

    return redirect('custom_auth:login')


# @login_required(login_url=reverse_lazy('custom_auth:login'))
@client_only
def datos_facturacion(request):
    print('DATOS DE FACTURACION')
    nroitems = carrito_get_nro(request)
    if nroitems < 1:
        return redirect('pedidos:carrito')

    # pedido = obtenerpedido(request)
    # if pedido:
    #     envio_id = int(pedido.envio_id)
    paises = Paises.objects.all().order_by('nombre')
    usuario = request.user
    initial = {}

    if usuario.is_authenticated():
        initial['usuario_id'] = usuario.id
        initial['usuario_nombres'] = usuario.nombres
        initial['usuario_apellidos'] = usuario.apellidos
        initial['usuario_email'] = usuario.email
        initial['usuario_telefono'] = usuario.telefono
        initial['usuario_tipodocumento'] = usuario.tipodocumento
        initial['usuario_nrodocumento'] = usuario.nrodocumento
        initial['usuario_pais'] = usuario.pais

    if request.method == 'POST':
        custom_inf = u''
        usuario_tipodocumento = request.POST.get('usuario_tipodocumento', '')

        # if usuario_tipodocumento:
        request.POST = request.POST.copy()
        if usuario.is_authenticated():
            request.POST['usuario_id'] = request.user.id
            request.POST['usuario_telefono'] = request.user.telefono
            request.POST['usuario_tipodocumento'] = request.user.tipodocumento
            request.POST['usuario_nrodocumento'] = request.user.nrodocumento
            request.POST['usuario_pais'] = request.user.pais
        request.POST['desc_cod'] = request.session.get('dscnt_cod', '')
        desc_num = request.session.get('dscnt', 0)

        if desc_num > 0:
            desc_num = CodigosDeDescuento.objects.get(id=desc_num).pct

        request.POST['desc_num'] = desc_num
        form = DatosPedidoForm(request.POST)

        if request.is_secure():
            http_protocol = "https://"
        else:
            http_protocol = "http://"
        base_url = '{0}{1}'.format(http_protocol, request.get_host())

        if form.is_valid():
            p = form.create_pedido(request)
            sesioncarrito = getlist_carrito(request)
            p.update_pedido_compra(sesioncarrito, Cursos)
            request.session['num_pedido'] = p.codigo

            if usuario.is_authenticated():
                if usuario.tipodocumento == '':
                    usuario.tipodocumento = p.usuario_tipodocumento
                if usuario.nrodocumento == '':
                    usuario.nrodocumento = p.usuario_nrodocumento
                if usuario.pais == '':
                    usuario.pais = p.usuario_pais
                usuario.save()

            # close_carrito(request)
            # # ---fin guardar datos de usuario --------------------------
            if p.metodopago == 'deposito':
                p.status = '1'
                threading.Thread(target=enviarCarrito, args=(p, base_url)).start()
                close_carrito(request)
                return redirect('pedidos:graciascompra')
            if p.metodopago == 'paypal':
                pyp_inf, created = PaypalInfo.objects.get_or_create(pk=1)
                if pyp_inf.paypal_account:
                    print '>>>>>>>>> hay paypal_account'
                    if request.is_secure():
                        http_protocol = "https://"
                    else:
                        http_protocol = "http://"
                    base_url = '{0}{1}'.format(http_protocol, request.get_host())
                    print(p.monto_dolares, '<-----monto dolares')
                    print(p.codigo, '<------- codigo')
                    paypal_dict = {
                        "business": pyp_inf.paypal_account,
                        "amount": p.monto_dolares,
                        "item_name": pyp_inf.paypal_itemname+' x{0}'.format(nroitems,),
                        "invoice": p.codigo,
                        "currency_code":"USD",
                        # "notify_url": base_url+reverse('paypal-pdt'),
                        "notify_url": base_url+reverse('pedidos:graciascompra_paypal'),
                        "return_url": base_url+reverse('pedidos:graciascompra_paypal'),
                        "cancel_return": base_url+reverse('pedidos:datos_facturacion'),
                        "custom": p.status_info
                    }
                    form = PayPalPaymentsForm(initial=paypal_dict)
                    send_paypal = True
                    return render('web/datos-envio.html', locals(),
                        context_instance=ctx(request))                        
                else:
                    print '>>>>>>>>> no hay paypal_account'
            if p.metodopago == 'pagoefectivo':
                request.session['num_pedido'] = p.codigo
                return redirect(reverse('pedidos:realizar_pago_pagoefectivo_logged'))

            return redirect('pedidos:datos_facturacion')
        else:
            print(form.errors)
        # metodopago = request.POST.get('metodopago', '')
        # if metodopago and pedido:
        #     form = DatosPagoForm(request.POST)
        #     if form.is_valid():
        #         if metodopago == 'payu':
        #             pedido, payudatos = form.pago_payu(request, pedido)
        #             payupost = True
        #         request.session['pedido'] = ''

                # request.session['sesioncarrito'] = ''

    # direcciones = Direccion.objects.filter(usuario=request.user, is_active=True).order_by('id')

    return render('web/datos-envio.html', locals(),
                  context_instance=ctx(request))


# @login_required(login_url=reverse_lazy('custom_auth:login'))
def realizar_pago_pagoefectivo_logged(request):

    if request.is_secure():
        http_protocol = "https://"
    else:
        http_protocol = "http://"
    base_url = '{0}{1}'.format(http_protocol, request.get_host())
    log.info("VIEW: Realizar Pago PagoEfectivo Logged")
    pedido_codigo = request.session.get('num_pedido')
    info = get_info()

    p = Pedido.objects.get(codigo=pedido_codigo)
    threading.Thread(target=enviarCarrito, args=(p, base_url)).start()
    # Limpiamos la session
    del request.session['num_pedido']

    # Datos para PagoefectivoData

    id_moneda = "1"
    total = p.monto_total
    metodos_pago = "1,2"
    cod_transaccion = p.codigo
    email = p.usuario_email
    usuarionombres = p.usuario_nombres
    usuarioapellidos = p.usuario_apellidos
    usuariodni = p.usuario_nrodocumento
    usuario = u"{0} {1}".format(
        p.usuario_nombres, p.usuario_apellidos)
    concepto_pago = "Compra en Tienda Virtual"
    telefono = p.usuario_telefono
    fecha_expira = time.strftime("%x")

    data = {
        'id_moneda': id_moneda,
        'total': total,
        'metodos_pago': metodos_pago,
        'cod_transaccion': cod_transaccion,
        'email': email,
        'usuarionombres': usuarionombres,
        'usuarioapellidos': usuarioapellidos,
        'usuariodni': usuariodni,
        'usuario': usuario,
        'concepto_pago': concepto_pago,
        'fecha_expira': fecha_expira
    }

    pagoefectivo_form = PagoEfectivoForm(data=data)
    # Validamos que el formulario enviado a PagoEfectivo sea válido
    realizar_pago_pagoefectivo = True

    if pagoefectivo_form.is_valid():
        log.info("PagoEfectivo Form is valid")
        pagoefectivo_form.save()

    else:
        log.warning("PagoEfectivo Form is invalid: ")
        print(pagoefectivo_form.errors)
        log.error(str(pagoefectivo_form.errors))
        log.error(str(pagoefectivo_form.non_field_errors()))
        data['enviado'] = False
        p = PagoEfectivoData(**data)
        p.save()
        return redirect(reverse('home'))

    pagoefectivo_url = settings.PAGOEFECTIVO_URL

    return render('web/pago-efectivo-form.html',
                  locals(), context_instance=ctx(request))


@csrf_exempt
def savecip_pagoefectivo(request):
    all_request = request.POST
    print(all_request, 'ALL REQUEST GET SAVECIP')
    print(all_request['codigocip'], 'CodigoCip')
    # print(request.session.get('num_pedido'), 'REQUEST SESSION PEDIDO')
    # pedido_codigo = request.session.get('num_pedido')
    p = Pedido.objects.get(codigo=all_request['orderidcomercio'])
    # p = Pedido.objects.first()
    print(p.codigo, 'PEDIDO LAST')

    p.token_response = all_request['token']

    p.cip = all_request['codigocip']
    p.estado_pago_efectivo = 'Pendiente'
    p.fecha_estado_pago_efectivo = all_request['fecha_emision']
    p.save()

    log.info("VIEW: SAVECIP PAGOEFECTIVO")
    # enviar_email_compra_task.delay(pedido.pedido_codigo, PAGO_EFECTIVO_MDP)
    # del request.session['num_pedido']

    return HttpResponse("CIP guardado")


@csrf_exempt
def estadocip_pagoefectivo(request):
    all_request = request.POST

    '''
    592: Pendiente de pago
    593: Pagado
    595: Expirado (sobrepaso el tiempo de limite).
    '''

    # p = Pedido.objects.first()

    print(all_request, 'ALL REQUEST GET SAVECIP')

    codigo_orden = all_request['orderidcomercio']

    p = Pedido.objects.get(codigo=codigo_orden)

    if all_request['estado'] == '592':
        p.estado_pago_efectivo = 'Pendiente'
        p.status = '1'

    if all_request['estado'] == '593':
        p.estado_pago_efectivo = 'Pagado'
        p.status = '2'

    if all_request['estado'] == '595':
        p.estado_pago_efectivo = 'Expirado'
        p.status = '3'

        # Getting email
        email = p.usuario_email
        # Send email notification
        email_expira_pagoefectivo(email)

    p.fecha_estado_pago_efectivo = all_request['fecha_emision']
    p.save()

    log.info("VIEW: ESTADOCIP SAVE PAGOEFECTIVO")
    # enviar_email_compra_task.delay(pedido.pedido_codigo, PAGO_EFECTIVO_MDP)

    return HttpResponse("CIP actualizado guardado")


@csrf_exempt
def get_token(request):
    data = {'status': 'ERROR'}
    if request.POST:
        print(request.POST, 'CODIGO TRANSACCION')
        codigo = request.POST['codtransaccion']
        p = Pedido.objects.get(codigo=codigo)
        token = p.token_response
        request.session['token_response'] = token
        data['status'] = 'OK'
    return JsonResponse(data)


def show_cip(request):
    url_pagoefectivo = settings.PAGOEFECTIVO_URL
    token_response = request.session['token_response']
    print(token_response, 'TOKEN CIP')
    close_carrito(request)

    return render('web/show-cip.html',
                  locals(), context_instance=ctx(request))


# @login_required(login_url=reverse_lazy('custom_auth:login'))
def graciascompra_paypal(request):
    pyp_inf, created = PaypalInfo.objects.get_or_create(pk=1)
    pdt_obj, failed = wCheckPDT(request)
    pedido = obtenerpedido(request)
    if request.is_secure():
        http_protocol = "https://"
    else:
        http_protocol = "http://"
    base_url = '{0}{1}'.format(http_protocol, request.get_host())
    if pedido is not None:
        monto_a_pagar = pedido.monto_dolares
        # print(pdt_obj,failed)
        if not failed and pdt_obj is not None:
            if pdt_obj.receiver_email == pyp_inf.paypal_account:
                if int(pdt_obj.payment_gross) == int(monto_a_pagar):
                    if pdt_obj.invoice == pedido.codigo:
                        pedido.status = '2'
                        pedido.save()
                    else:
                        pedido.status = '3'
                        pedido.save()
                        return redirect('pedidos:errorcompra_paypal')
                    # pedido.status = '2'
                    # pedido.save()

                    pdt_obj.flag = True
                    pdt_obj.flag_info = 'CONFORME'
                    close_carrito(request)
                    pdt_obj.save()
                    # request.session['countcart'] = 0
                    pedido.status = '2'
                    threading.Thread(
                        target=enviarCarrito, args=(pedido, base_url)).start()
                    request.session["paypal_pay"] = True
                    return redirect('pedidos:graciascompra')

                else:
                    pedido.status = '3'
                    pedido.save()
                    reason_tmp = "Monto abonado {0} monto solicitado {1}"
                    pdt_obj.flag_info = reason_tmp.format(
                        pdt_obj.payment_gross, monto_a_pagar)
                    pdt_obj.flag = False
                    pdt_obj.save()
                    close_carrito(request)
            else:
                pedido.status = '1'
                threading.Thread(
                    target=enviarCarrito, args=(pedido, base_url)).start()
                pedido.save()
                # close_carrito(request)
        else:
            pedido.status = '2'
            pedido.save()
            threading.Thread(
                target=enviarCarrito, args=(pedido, base_url)).start()
            close_carrito(request)
            # print(pdt_obj,failed)
        return redirect('pedidos:errorcompra_paypal')
    return redirect('pedidos:datos_facturacion')


# @login_required(login_url=reverse_lazy('custom_auth:login'))
def graciascompra(request):
    paypal_pay = request.session.get("paypal_pay", False)
    seccion, created = PaypalInfo.objects.get_or_create(pk=1)
    # print(request.session['num_pedido'])
    pedido = Pedido.objects.get(codigo=request.session['num_pedido'])
    print(pedido, 'PEDIDO')
    return render(
        'web/mensaje-pago-exitoso.html',
        locals(), context_instance=ctx(request))


# @login_required(login_url=reverse_lazy('custom_auth:login'))
def errorcompra_paypal(request):
    error_pyp = True
    return render('404.html', locals(), context_instance=ctx(request))

#
# def payu_respuesta(request):
#     log.info("VIEW: Payu exito")
#     # ApiKey = "4Vj8eK4rloUd272L48hsrarnUA"
#
#     merchantId = settings.PAYU_MERCHANTID
#     ApiKey = settings.PAYU_APIKEY
#
#     merchant_id = request.GET.get('merchant_id', '')
#     referenceCode = request.GET.get('referenceCode', '')
#     TX_VALUE = request.GET.get('TX_VALUE', '')
#     currency = request.GET.get('currency', '')
#     transactionState = request.GET.get('transactionState', '')
#     New_value = TX_VALUE
#     # print New_value
#     firma_cadena = ApiKey+'~'+merchant_id+'~'+referenceCode+'~'+New_value+'~'+currency+'~'+transactionState
#     firmacreada = md5(firma_cadena).hexdigest()
#
#     firma = request.GET.get('signature', '')
#
#     reference_pol = request.GET.get('reference_pol', '')
#     cus = request.GET.get('cus', '')
#     description = request.GET.get('description', '')
#     pseBank = request.GET.get('pseBank', '')
#     lapPaymentMethod = request.GET.get('lapPaymentMethod', '')
#     transactionId = request.GET.get('transactionId', '')
#
#     transactionState = '%s' % request.GET.get('transactionState', '')
#     lapResponseCode = '%s' % request.GET.get('lapResponseCode', '')
#     mensaje_t = '%s' % request.GET.get('mensaje', '')
#     processingDate = '%s' % request.GET.get('processingDate', '')
#
#     if transactionState == '4':
#         estadoTx = "Transacción Aprobada"
#     elif transactionState == '6':
#         estadoTx = "Transacción Incompleta"
#     elif transactionState == '104':
#         estadoTx = "Error"
#     elif transactionState == '7':
#         estadoTx = "Transacción pendiente"
#     else:
#         estadoTx=mensaje_t
#
#     respuestapayu = equivalencia_payu(lapResponseCode)
#     resumen = u'<p>N° Pedido: %s<br/>N° Operacion: %s<br/>Fecha: %s<br/>Monto total: %s</p>' % (referenceCode,reference_pol,processingDate,TX_VALUE)
#     request.session['resp_validar'] = transactionState
#     request.session['resp_contenido'] = respuestapayu
#     request.session['resp_titulo'] = estadoTx
#     request.session['resp_resumen'] = resumen
#     return redirect(reverse('pedidos:payu_exito'))
#
#
# @csrf_exempt
# def payu_validar(request):
#     """ Paso de retorno al finalizar el pedido """
#     log.info("VIEW: valida_pedido")
#     log.info("Recibiendo respuesta de payu.")
#
#     codigo = request.session.get('pedido', '')
#     if codigo != '':
#         del request.session['pedido']
#
#     rechazo = True
#     pedido = None
#     pedido_codigo = None
#     PEDIDO_PAGADO = '2'
#     PEDIDO_RECHAZADO = '3'
#
#     if request.method == 'POST':
#         try:
#             pago = PayuResponse.objects.create(
#                 response_code_pol= request.POST.get('response_code_pol', ''),
#                 phone= request.POST.get('phone', ''),
#                 additional_value= request.POST.get('additional_value', ''),
#                 test= request.POST.get('test', ''),
#                 transaction_date= request.POST.get('transaction_date', ''),
#                 cc_number= request.POST.get('cc_number', ''),
#                 cc_holder= request.POST.get('cc_holder', ''),
#                 error_code_bank= request.POST.get('error_code_bank', ''),
#                 billing_country= request.POST.get('billing_country', ''),
#                 bank_referenced_name= request.POST.get('bank_referenced_name', ''),
#                 description= request.POST.get('description', ''),
#                 administrative_fee_tax= request.POST.get('administrative_fee_tax', ''),
#                 value= request.POST.get('value', ''),
#                 administrative_fee= request.POST.get('administrative_fee', ''),
#                 payment_method_type= request.POST.get('payment_method_type', ''),
#                 office_phone= request.POST.get('office_phone', ''),
#                 email_buyer= request.POST.get('email_buyer', ''),
#                 response_message_pol= request.POST.get('response_message_pol', ''),
#                 error_message_bank= request.POST.get('error_message_bank', ''),
#                 shipping_city= request.POST.get('shipping_city', ''),
#                 transaction_id= request.POST.get('transaction_id', ''),
#                 sign= request.POST.get('sign', ''),
#                 tax= request.POST.get('tax', ''),
#                 payment_method= request.POST.get('payment_method', ''),
#                 billing_address= request.POST.get('billing_address', ''),
#                 payment_method_name= request.POST.get('payment_method_name', ''),
#                 pse_bank= request.POST.get('pse_bank', ''),
#                 state_pol= request.POST.get('state_pol', ''),
#                 date= request.POST.get('date', ''),
#                 nickname_buyer= request.POST.get('nickname_buyer', ''),
#                 reference_pol = request.POST.get('reference_pol', ''),
#                 currency = request.POST.get('currency', ''),
#                 risk = request.POST.get('risk', ''),
#                 shipping_address = request.POST.get('shipping_address', ''),
#                 bank_id = request.POST.get('bank_id', ''),
#                 payment_request_state = request.POST.get('payment_request_state', ''),
#                 customer_number = request.POST.get('customer_number', ''),
#                 administrative_fee_base = request.POST.get('administrative_fee_base', ''),
#                 attempts = request.POST.get('attempts', ''),
#                 merchant_id = request.POST.get('merchant_id', ''),
#                 exchange_rate = request.POST.get('exchange_rate', ''),
#                 shipping_country = request.POST.get('shipping_country', ''),
#                 installments_number = request.POST.get('installments_number', ''),
#                 franchise = request.POST.get('franchise', ''),
#                 payment_method_id = request.POST.get('payment_method_id', ''),
#                 extra1 = request.POST.get('extra1', ''),
#                 extra2 = request.POST.get('extra2', ''),
#                 antifraudMerchantId = request.POST.get('antifraudMerchantId', ''),
#                 extra3 = request.POST.get('extra3', ''),
#                 nickname_seller = request.POST.get('nickname_seller', ''),
#                 ip = request.POST.get('ip', ''),
#                 airline_code = request.POST.get('airline_code', ''),
#                 billing_city = request.POST.get('billing_city', ''),
#                 pse_reference1 = request.POST.get('pse_reference1', ''),
#                 reference_sale = request.POST.get('reference_sale', ''),
#                 pse_reference3 = request.POST.get('pse_reference3', ''),
#                 pse_reference2 = request.POST.get('pse_reference2', '')
#             )
#         except:
#             pass
#         merchantId = settings.PAYU_MERCHANTID
#         ApiKey = settings.PAYU_APIKEY
#         currency = settings.PAYU_CURRENCY
#
#         # merchant_id = 508029
#         reference_sale = request.POST.get('reference_sale', '')
#         codigo = reference_sale
#         value_c = '%s' % request.POST.get('value', '')
#         value = value_c.split('.')
#         fvalue = value[0]
#         svalue = value[1]
#         fsvalue = '%s' % int(int(svalue)/10)
#         if int(svalue) % 10 > 0:
#             ssvalue = int(svalue)%10
#         else:
#             ssvalue = ''
#         newvalue = '%s.%s%s' % (fvalue, fsvalue, ssvalue)
#         state_pol = request.POST.get('state_pol', '')
#         sign = md5(ApiKey+'~'+merchantId+'~'+reference_sale+'~'+newvalue+'~'+currency+'~'+state_pol).hexdigest()
#         return_sign = request.POST.get('sign', '')
#
#         # print '%s---%s---%s--%s'%(value, newvalue, sign,return_sign)
#         # try:
#         pedido = Pedido.objects.get(codigo=codigo)
#         pedido.payu_idpago = pago.id
#         pedido.payu_transaction_id = pago.transaction_id
#         pedido.medio_pago = 'PayU'
#         pago.pedido = pedido
#         pago.respuesta = equivalencia_payu(pago.response_message_pol)
#         pago.save()
#         # if sing == return_sign:
#
#         if sign == return_sign and state_pol == '4':
#             pedido.status = PEDIDO_PAGADO
#             pedido.status_pagado = True
#             # res = DetallePedido.objects.filter(pedido=pedido).exclude(giftcard='')
#
#             log.info('VIEW: guardando pedido procesado con payu: %s'% pedido.codigo)
#             resp = ''
#             # try:
#             #     resp = pedido.erp_pedido_save()
#             # except Exception as e:
#             #     detalles = DetallePedido.objects.filter(pedido=pedido)
#             #     wnumsesion = pedido.wnumsesion
#             #     ProductoCarrito.objects.filter(numsession=wnumsesion)
#             #     for i in detalles:
#             #         producto = Producto.objects.get(pk=int(i.producto_id))
#             #         producto.stock = producto.stock - int(i.cantidad)
#             #         producto.save()
#
#             # if resp != '':
#             #     pedido.nummov = resp
#                 # pedido.save()
#         else:
#             pedido.status = PEDIDO_RECHAZADO
#         pedido.save()
#         if pedido.status == '2':
#             # payu_email_administrador_pedido_ok(pedido)
#             pago_email_cliente(pedido)
#             pago_email_administrador(pedido)
#         return HttpResponse('ok')
#
#     return HttpResponse('none')
#
#
# def payu_exito(request):
#     log.info("VIEW: Alignet exito")
#     resp_titulo = request.session.get('resp_titulo', '')
#     resp_contenido = request.session.get('resp_contenido', '')
#     resp_validar = request.session.get('resp_validar', '')
#     resp_resumen = request.session.get('resp_resumen', '')
#     if resp_titulo != '':
#         del request.session['resp_titulo']
#     if resp_validar != '':
#         del request.session['resp_validar']
#     if resp_contenido != '':
#         del request.session['resp_contenido']
#     if resp_resumen != '':
#         del request.session['resp_resumen']
#
#     return render('web/mensaje-compraexitosa.html', locals(),
#         context_instance=ctx(request))


def facturacion(request, token):
    log.info('VIEW: facturacion')
    # head = 'datos de facturacion'
    # pedido_codigo = request.session.get('num_pedido')
    pedido = Pedido.objects.get(token=token)
    codigo = pedido.codigo
    if pedido.completed:
        return redirect('pedidos:gracias_datos')

    paises = Paises.objects.all().order_by('nombre')
    initial = {}
    if pedido.usuario_id != "0":
        client = Usuario.objects.get(id=pedido.usuario_id)
        initial['usuario_telefono'] = client.telefono
        initial['usuario_tipodocumento'] = client.tipodocumento
        initial['usuario_nrodocumento'] = client.nrodocumento
        initial['usuario_pais'] = client.pais

    initial['usuario_nombres'] = pedido.usuario_nombres
    initial['usuario_apellidos'] = pedido.usuario_apellidos
    initial['usuario_email'] = pedido.usuario_email
    if request.POST:
        form = UpdatePedidoForm(request.POST)
        if form.is_valid():
            form.update_pedido(request)
            return redirect('pedidos:gracias_datos')
        else:
            print(form.errors)
    return render(
        'web/facturacion.html', locals(),
        context_instance=ctx(request))


def gracias_datos(request):
    log.info('VIEW: Datos completados')

    return render(
        'web/mensaje-datos-completados.html', locals(),
        context_instance=ctx(request))
