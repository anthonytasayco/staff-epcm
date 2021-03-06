# -*- coding: utf-8 -*-
from logging import getLogger

from uuid import uuid4
from django.forms import ModelForm
from django.template.loader import get_template
from django.template import Context
from django.core.mail import EmailMessage,send_mass_mail
from django.conf import settings
from django import forms
# from apps.web.models import Contactanos, Suscripcion, TrabajaConNosotros, Pedido, PedidoNoCart
from apps.web.util import get_info
from django.utils.translation import ugettext as _
from apps.pedidos.utilscart import (carrito_result,)
# from apps.catalogo.models import Producto
from apps.pedidos.models import Pedido, PaypalInfo, PagoEfectivoData
from apps.custom_auth.models import Direccion, Usuario, Distrito
from django.core.urlresolvers import reverse, reverse_lazy
global STATIC_URL, MEDIA_URL
STATIC_URL = settings.STATIC_URL
MEDIA_URL = settings.MEDIA_URL
EMAIL_DEVELOPER = settings.EMAIL_DEVELOPER
# from hashlib import sha512, md5

log = getLogger('django')


class DatosPedidoForm(forms.Form):
    usuario_id = forms.CharField(label='id usuario', required=False)
    usuario_nombres = forms.CharField(label='nombres', required=False)
    usuario_apellidos = forms.CharField(label='apellidos', required=False)
    usuario_email = forms.CharField(label='email', required=False)
    usuario_telefono = forms.CharField(label='telefono', required=False)
    usuario_tipodocumento = forms.CharField(
        label='tipo documento', required=False)
    usuario_nrodocumento = forms.CharField(
        label='nro documento', required=False)
    usuario_pais = forms.CharField(label='pais', required=False)
    usuario_labora = forms.CharField(label='Centro laboral', required=False)
    usuario_cargo = forms.CharField(label='Cargo', required=False)
    usuario_telefono_oficina = forms.CharField(
        label='Teléfono oficina', required=False)
    usuario_fax = forms.CharField(label='Fax', required=False)
    metodopago = forms.CharField(label='Método de pago', required=False)
    desc_cod = forms.CharField(label='Código de descuento', required=False)
    desc_num = forms.DecimalField(label='% de descuento', required=False)

    factura_tipo = forms.CharField(label='tipo documento', required=False)
    factura_ruc = forms.CharField(label='ruc', required=False)
    factura_razonsocial = forms.CharField(label='Razon social', required=False)
    factura_direccionfiscal = forms.CharField(
        label='Direccion fiscal', required=False)
    factura_contacto = forms.CharField(label='Contacto', required=False)
    factura_correo = forms.CharField(
        label='Correo de facturación', required=False)

    def create_pedido(self, request):
        cd = self.cleaned_data
        fields = ['metodopago', 'desc_cod', 'desc_num',
                  'usuario_id', 'usuario_nombres', 'usuario_apellidos',
                  'usuario_email', 'usuario_telefono', 'usuario_tipodocumento',
                  'usuario_nrodocumento', 'usuario_pais',
                  'usuario_labora', 'usuario_cargo',
                  'usuario_telefono_oficina', 'usuario_fax',
                  'factura_ruc', 'factura_razonsocial',
                  'factura_direccionfiscal',
                  'factura_contacto', 'factura_correo']
        dd = {}
        for f in fields:
            dd[f] = cd[f]
        p = Pedido(**dd)
        p.token = str(uuid4())[:30]
        p.save()
        if cd.get('factura_tipo', False):
            tipo = 'factura'
        else:
            tipo = 'boleta'
        p.factura_tipo = tipo
        p.codigo = 'PE-%s' % (p.id + 10000)
        request.session['pedido'] = p.codigo
        return p


class UpdatePedidoForm(forms.Form):
    codigo = forms.CharField(label='codigo', required=False)
    usuario_nombres = forms.CharField(label='nombres', required=False)
    usuario_apellidos = forms.CharField(label='apellidos', required=False)
    usuario_email = forms.CharField(label='email', required=False)
    usuario_telefono = forms.CharField(label='telefono', required=False)
    usuario_tipodocumento = forms.CharField(
        label='tipo documento', required=False)
    usuario_nrodocumento = forms.CharField(
        label='nro documento', required=False)
    usuario_pais = forms.CharField(label='pais', required=False)
    usuario_labora = forms.CharField(label='Centro laboral', required=False)
    usuario_cargo = forms.CharField(label='Cargo', required=False)
    usuario_telefono_oficina = forms.CharField(
        label='Teléfono oficina', required=False)
    usuario_fax = forms.CharField(label='Fax', required=False)
    metodopago = forms.CharField(label='Método de pago', required=False)
    desc_cod = forms.CharField(label='Código de descuento', required=False)
    desc_num = forms.DecimalField(label='% de descuento', required=False)

    factura_tipo = forms.CharField(label='tipo documento', required=False)
    factura_ruc = forms.CharField(label='ruc', required=False)
    factura_razonsocial = forms.CharField(label='Razon social', required=False)
    factura_direccionfiscal = forms.CharField(
        label='Direccion fiscal', required=False)
    factura_contacto = forms.CharField(label='Contacto', required=False)
    factura_correo = forms.CharField(
        label='Correo de facturación', required=False)

    def update_pedido(self, request):
        cd = self.cleaned_data
        fields = ['codigo', 'usuario_nombres', 'usuario_apellidos',
                  'usuario_email', 'usuario_telefono', 'usuario_tipodocumento',
                  'usuario_nrodocumento', 'usuario_pais',
                  'usuario_labora', 'usuario_cargo',
                  'usuario_telefono_oficina', 'usuario_fax',
                  'factura_ruc', 'factura_razonsocial',
                  'factura_direccionfiscal',
                  'factura_contacto', 'factura_correo']

        dd = {}
        for f in fields:
            if not f == 'codigo':
                dd[f] = cd[f]
        dd['completed'] = True
        p = Pedido.objects.filter(codigo=cd['codigo']).update(**dd)

        return p


class DatosPagoForm(forms.Form):
    metodopago = forms.CharField(label='metodo pago', required=False)

    # def pago_payu(self, request, pedido):
    #     urlraiz = request.build_absolute_uri('/')[:-1]
    #     payu_url_web = settings.PAYU_URL_WEB
    #     payu_test_web = settings.PAYU_TEST_WEB
    #     gen_merchantId = settings.PAYU_MERCHANTID
    #     gen_ApiKey = settings.PAYU_APIKEY
    #
    #     gen_tax = '0'
    #     gen_taxReturnBase = '0'
    #     gen_responseUrl = '%s%s' % (urlraiz, reverse('catalogo:payu_respuesta'))
    #     gen_confirmationUrl = '%s%s' % (urlraiz, reverse('catalogo:payu_validar'))
    #
    #     payupost = True
    #     send_description = 'Compra en tienda web'
    #     send_amount = "%.2f" % pedido.monto_total
    #     # send_amount = '120.00'
    #     send_test = payu_test_web
    #     send_buyerEmail = pedido.usuario_email
    #     send_buyerFullName = '%s' % pedido.usuario_nombres
    #     send_currency = settings.PAYU_CURRENCY
    #     send_accountId = settings.PAYU_ACCOUNTID_WEB #'512323'
    #
    #     send_referenceCode = '%s' % pedido.codigo
    #     # print gen_ApiKey+'~'+gen_merchantId+'~'+send_referenceCode+'~'+send_amount+'~'+send_currency
    #     send_signature = md5(gen_ApiKey+'~'+gen_merchantId+'~'+send_referenceCode+'~'+send_amount+'~'+send_currency).hexdigest()
    #     # ********************************************************
    #     send_shippingAddress = '%s' % pedido.envio_direccion
    #     send_shippingCity = '%s' % pedido.envio_provincia_nombre
    #     send_shippingCountry = 'PE'
    #
    #     pedido.sendp_signature = send_signature
    #     pedido.sendp_accountId = send_accountId
    #     pedido.sendp_referenceCode = send_referenceCode
    #     pedido.sendp_currency = send_currency
    #     pedido.sendp_description = send_description
    #     pedido.sendp_amount = send_amount
    #     pedido.sendp_test = send_test
    #     pedido.sendp_buyerEmail = send_buyerEmail
    #     pedido.sendp_buyerFullName = send_buyerFullName
    #     pedido.sendp_shippingAddress = send_shippingAddress
    #     pedido.sendp_shippingCity = send_shippingCity
    #     pedido.sendp_shippingCountry = send_shippingCountry
    #     pedido.medio_pago = '1' # payu
    #
    #     pedido.status_enviado = True
    #     pedido.save()
    #     payudatos = {}
    #     payudatos['gen_merchantId'] = gen_merchantId
    #     payudatos['gen_tax'] = gen_tax
    #     payudatos['gen_taxReturnBase'] = gen_taxReturnBase
    #     payudatos['gen_responseUrl'] = gen_responseUrl
    #     payudatos['gen_confirmationUrl'] = gen_confirmationUrl
    #     payudatos['payu_url_web'] = payu_url_web
    #     return (pedido, payudatos)


def enviaEmail(pedido, base_url):
    if pedido.status == '3':
        return None
    pay_info, created = PaypalInfo.objects.get_or_create(pk=1)
    if pay_info.notificar_a:
        info = get_info()
        c_d = dict()
        c_d['STATIC_URL'] = (info.site + STATIC_URL)
        c_d['info'] = info
        c_d['pedido'] = pedido
        c_d['pay'] = pay_info

        c_d['url_complete'] = "{}/{}{}".format(
            base_url, 'post-payment/datos-facturacion/', pedido.token)
        d = Context(c_d)

        htmly = get_template('email/carrito_detalle.html')
        html_content = htmly.render(d)
        asunto = u"EPCM: Compra de cursos vía {0} (Orden de compra: {1})".format(
            pedido.metodopago,pedido.codigo)
        mail = u'{0}<{1}>'.format(settings.PROJECT_NAME,
            settings.DEFAULT_FROM_EMAIL)
        if pedido.usuario_email:
            msg = EmailMessage(asunto, html_content, mail,
                           [pedido.usuario_email],bcc=[pay_info.notificar_a])
        else:
            msg = EmailMessage(asunto, html_content, mail,
                           [pay_info.notificar_a])
        msg.content_subtype = "html"
        msg.send()


class PagoEfectivoForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(PagoEfectivoForm, self).__init__(*args, **kwargs)
        self.fields['id_moneda'].required = True
        self.fields['total'].required = True
        self.fields['metodos_pago'].required = True
        self.fields['cod_transaccion'].required = True
        self.fields['email'].required = True
        self.fields['usuarionombres'].required = True
        self.fields['usuarioapellidos'].required = True
        self.fields['usuario'].required = True
        self.fields['concepto_pago'].required = True

    class Meta:
        fields = (
            'id_moneda', 'total', 'metodos_pago', 'cod_transaccion',
            'email', 'usuarionombres',
            'usuarioapellidos', 'usuario', 'concepto_pago')
        model = PagoEfectivoData
