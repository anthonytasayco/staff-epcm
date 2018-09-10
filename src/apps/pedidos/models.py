# -*- coding: utf-8 -*-
# IMPORTS
from datetime import date
from logging import getLogger
from urlparse import urlparse
from random import randint
from decimal import Decimal

from django.conf import settings
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db import models
# from apps.custom_auth.models import Direccion, Usuario
from ckeditor.fields import RichTextField
from filebrowser.fields import FileBrowseField
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.shortcuts import get_object_or_404

from apps.custom_auth.models import Usuario

from apps.core.models import AuditableModel, SlugModel

from apps.cursos.models import Cursos as ProductoModel
from .constants import PAGO_EFECTIVO_ESTADO_CHOICES
from django.db.models import signals
from django.dispatch import dispatcher
from json2html import *
from uuid import uuid4

tmplt = u'''Este pedido usó este código {0} 
aplicando así un {1}% de descuento 
Monto Bruto: {2} USD | {3} PEN
Monto a Pagar: {4} USD | {5} PEN
se usó una taza referencial de {6} soles por dolar.
'''


class PaypalInfo(AuditableModel):
    paypal_account = models.CharField("Usuario de Paypal (Email)", max_length=128)
    paypal_itemname = models.CharField("Nombre de Item en Paypal", max_length=50,
                                        default='EPCM Courses Pack')
    tazarf = models.DecimalField("Taza referencial de conversión a dolares",
                    max_digits=5, decimal_places=2, default=3.44)

    deposito = RichTextField(config_name='small', verbose_name='Descripción \
        de pago por deposito')
    notificar_a = models.EmailField("Email a notificar de compra", blank=True)

    class Meta:
        verbose_name = u'Información de pago'
        verbose_name_plural = u'Información de Pago Online'
    
    def __unicode__(self):
        return u'{0}'.format(self.paypal_account,)


class Pedido(models.Model):
    STATUS_CHOICES = (
        ('1', 'Pendiente'),
        ('2', 'Pagado'),
        ('3', 'Cancelado/Denegado')
    )

    status = models.CharField(max_length=1, choices=STATUS_CHOICES, default='1')
    status_info = models.TextField("Información de pedido",blank=True)
    created = models.DateTimeField(auto_now_add=True)
    codigo = models.CharField('Codigo', max_length=10)
    metodopago = models.CharField('metodopago', max_length=80)

    status_pagado = models.BooleanField('Pagado Auto', default=False)
    status_enviado = models.BooleanField('¿Enviado a la pasarela?', default=False)

    monto_totalcompra = models.DecimalField('Total Compra', max_digits=14, decimal_places=2, default=0)
    monto_delivery = models.DecimalField('Delivery', max_digits=14, decimal_places=2, default=0)
    monto_descuento = models.DecimalField('Descuento', max_digits=14, decimal_places=2, default=0)
    monto_total = models.DecimalField('Monto Total', max_digits=14, decimal_places=2, default=0)
    monto_tasacambio = models.DecimalField('Tasa de Cambio', max_digits=10, decimal_places=2, default=0)
    monto_dolares = models.DecimalField('Dolares', max_digits=14, decimal_places=2, default=0)


    usuario_id = models.CharField("Usuario id", max_length=5, blank=True)
    usuario_nombres = models.CharField("Nombres", max_length=250, blank=True)
    usuario_apellidos = models.CharField("Apellidos", max_length=250, blank=True)
    usuario_email = models.CharField('Email', max_length=250, blank=True)
    usuario_telefono = models.CharField('Telefono', max_length=150, blank=True)
    usuario_tipodocumento = models.CharField("tipo documento", max_length=250, blank=True)
    usuario_nrodocumento = models.CharField("nro documento", max_length=250, blank=True)
    usuario_pais = models.CharField("pais", max_length=250, blank=True)

    # envio -------------------------------------------------------------------------------
    # envio_id = models.CharField("Direccion Envio id", max_length=250, blank=True)
    # envio_nombres = models.CharField("casa casad campo, etc", max_length=250, blank=True)
    # envio_telefono = models.CharField('Telefono', max_length=150, blank=True)
    # envio_direccion = models.CharField('Direccion', max_length=250, blank=True)
    # envio_distrito = models.CharField('Distrito id', max_length=150, blank=True)
    # envio_distrito_nombre = models.CharField('Distrito', max_length=150, blank=True)
    # envio_provincia_nombre = models.CharField('Provincia', max_length=150, blank=True)
    # envio_region_nombre = models.CharField('Region', max_length=150, blank=True)
    # envio_referencia = models.TextField('Referencia', blank=True)

    factura_tipo = models.CharField('tipo documento', max_length=150, blank=True)

    factura_ruc = models.CharField("ruc", max_length=25, blank=True)
    factura_razonsocial = models.CharField("Razon social", max_length=250, blank=True)
    factura_direccionfiscal = models.CharField("Direccion fiscal", max_length=250, blank=True)

    desc_cod = models.CharField("Código de descuento usado", max_length=32, blank=True)
    desc_num = models.DecimalField('% de descuento', max_digits=8, decimal_places=2)

    # desc_num = models.PositiveSmallIntegerField('% de descuento', default=0)
    # sendp_signature = models.CharField("send_signature", max_length=250, blank=True)
    # sendp_accountId = models.CharField("send_accountId", max_length=50, blank=True)
    # sendp_referenceCode = models.CharField("send_referenceCode codigo", max_length=50, blank=True)
    # sendp_currency = models.CharField("send_currency", max_length=3, blank=True)
    #
    # sendp_description = models.CharField("send_description", max_length=50, blank=True)
    # sendp_amount = models.CharField("send_amount", max_length=50, blank=True)
    # sendp_test = models.CharField("send_test", max_length=50, blank=True)
    # sendp_buyerEmail = models.CharField("send_buyerEmail", max_length=250, blank=True)
    # sendp_buyerFullName = models.CharField("send_buyerFullName", max_length=250, blank=True)
    #
    # sendp_shippingAddress = models.CharField("send_shippingAddress", max_length=150, blank=True)
    # sendp_shippingCity = models.CharField("send_shippingCity", max_length=150, blank=True)
    # sendp_shippingCountry = models.CharField("send_shippingCountry", max_length=150, blank=True)
    #
    # payu_idpago = models.CharField("send_test", max_length=50, blank=True)
    # payu_transaction_id = models.CharField("send_test", max_length=150, blank=True)
    # send_active = models.BooleanField('se envio a la pasarela', default=False)

    # PAGO EFECTIVO

    cip = models.CharField(max_length=30, blank=True)
    estado_pago_efectivo = models.CharField(
        max_length=10, blank=True,
        choices=PAGO_EFECTIVO_ESTADO_CHOICES)
    fecha_estado_pago_efectivo = models.DateTimeField(blank=True, null=True)
    token_response = models.CharField('Token response',
                                      blank=True, max_length=220)
    extornado = models.BooleanField(default=False)

    class Meta:
        verbose_name = u''
        verbose_name_plural = u'≡ Pedidos'
        ordering = ['-created']

    def __unicode__(self):
        return '%s' % self.codigo

    def estado(self):
        if self.status == '1':
            return '<span style="color:gray">Pendiente</span>'
        if self.status == '2':
            return '<span style="color:green">Pagado</span>'
        if self.status == '3':
            return '<span style="color:#e30421">Rechazado</span>'

    # usuario,codigo,
    # pagado,vencido,extornado,cip
    # resumen,totalcompra,delivery,total, tipopago
    # fact,envio,

    def full_name(self):
        return '%s %s' % (self.env_nombres, self.env_apellidos)

    def get_absolute_url(self):
        return '/admin-staff/catalogo/carrito/{0}'.format(self.id)

    def detalle_pedido(self):
        return DetallePedido.objects.filter(pedido=self)

    def getUSD(self,monto,taza):
        return round(float(monto)/float(taza),2)

    def update_pedido_compra(self, sesioncarrito, Producto):
        suma = 0
        for i in sesioncarrito:
            prod = get_object_or_404(Producto, pk=i['id'])

            if prod.precio:
                precio_float = float(prod.precio)
            else:
                precio_float = 0
            if i['cantidad']:
                cantidad_float = int(i['cantidad'])
            else:
                cantidad_float = 1
            descuento = 0
            total = precio_float * cantidad_float - descuento
            suma = suma + total
            # producto_marca = ''
            # if prod.marca:
            #     producto_marca = prod.marca.nombre
            DetallePedido.objects.create(pedido=self, cantidad=cantidad_float,
                producto_nombre=prod.nombre,
                producto_marca=prod.categoria.nombre,
                producto_precio=prod.precio,
                producto_codigo=prod.cod,
                importe=total
            )

        delivery = self.monto_delivery
        if self.desc_num > 0:
            descuento = Decimal(self.desc_num)
            descuento_grupo = Decimal(suma) * (descuento / Decimal(100.000000))
        else:
            descuento_grupo = 0
        # pd = self.monto_porcentajedescuento
        # if pd > 0:
        #     last = suma
        #     last = (pd)*last/100
        #     descuento_grupo = float("{0:.1f}".format(last))
        total = float(suma) - float(descuento_grupo)+ float(delivery)
        # sumapeso = 0
        # self.otros_totalpeso = sumapeso
        pyp, created = PaypalInfo.objects.get_or_create(pk=1)
        self.monto_tasacambio = pyp.tazarf
        self.monto_dolares = self.getUSD(total,pyp.tazarf)#   round(float(total)/float(pyp.tazarf),2)
        self.monto_totalcompra = suma
        self.monto_descuento = descuento_grupo
        # self.monto_delivery = delivery
        self.monto_total = total

        self.status_info = tmplt.format(
                self.desc_cod,
                self.desc_num,
                self.getUSD(suma,pyp.tazarf),
                self.monto_totalcompra,
                self.getUSD(total,pyp.tazarf),
                self.monto_total,
                pyp.tazarf,
            )

        self.save()


class DetallePedido(models.Model):
    pedido = models.ForeignKey(Pedido, related_name='pedido')
    cantidad = models.CharField(max_length=6)
    importe = models.DecimalField('importe', max_digits=14, decimal_places=2, default=0)

    producto_precio = models.DecimalField('Precio unitario', max_digits=14, decimal_places=2, default=0)
    producto_nombre = models.CharField('Producto', max_length=150, blank=True)
    producto_marca = models.CharField('Marca', max_length=150, blank=True)
    # producto_descripcion = models.TextField('Descripcion', blank=True)
    # producto_textounidades = models.CharField('unidades', max_length=150, blank=True)
    producto_codigo = models.CharField('Código', max_length=150, blank=True)
    producto_id = models.CharField('id', max_length=15, blank=True)

    # producto_imagen_path = models.CharField('Imagen path', max_length=250, blank=True)

    def __unicode__(self):
        return self.producto_nombre

    def sub_total(self):
        return float(self.cantidad) * float(self.producto_precio)

    def cantidad_int(self):
        return int(self.cantidad)

    def producto(self):
        return ProductoModel.objects.get(pk=int(self.producto_id))



class CodigosDeDescuento(AuditableModel):
    onetime = models.BooleanField("Código de un solo uso",default=False)
    used = models.BooleanField("El Código ha sido usado",default=False, editable=False)
    ond = models.BooleanField("El Código valido solo por un Día",default=False,
            help_text="Si esta opción esta habilitada, se usará la fecha de inicio como único día de uso")
    ini = models.DateField('Fecha de Inicio', default=date.today,
                        help_text="si el inicio es igual al fín el código es de uso indefinido,\
                                        excepto este habilitado solo por un Día")
    end = models.DateField('Fecha de Fin', default=date.today)
    cod = models.CharField("Código", max_length=16, blank=True, unique_for_year='ini')
    pct = models.DecimalField('% de descuento', max_digits=8, decimal_places=6, default=20)
    # pct = models.PositiveSmallIntegerField('% de descuento', default=20)
    num = models.PositiveIntegerField("Número máximo de usos", default=0,
                                        help_text='0 significa indefinido')

    class Meta:
        verbose_name = u'códigos'
        verbose_name_plural = u'Códigos de descuentos'
        ordering = ['-ini']

    def usedTimes(self):
        return Pedido.objects.filter(status__in=['1','2'], desc_cod=self.cod).count()

    @property
    def is_valid(self):
        valid = True
        if self.onetime and self.used:
            return False
        if self.num > 0 and self.usedTimes() >= self.num:
            return False
        if self.ond and self.ini != date.today():
            return False
        if self.ini != self.end:
            return self.ini <= date.today() <= self.end
        self.used = True
        self.save()
        return valid

    def save(self, *args, **kwargs):
        azar = randint(0,99)
        if self.cod == '':
            if azar % 9 == 0:
                self.cod = str(uuid4())[5:32:2][:16]
            if azar % 7 == 0:
                self.cod = str(uuid4())[2:32:3][:16]
            if azar % 3 == 0:
                self.cod = str(uuid4())[2:32:2][:16]
            else:
                self.cod = str(uuid4())[14:32][:16]

        super(CodigosDeDescuento, self).save(*args, **kwargs)

    def __unicode__(self):
        return u'{0}'.format(self.cod,)
#
#
# class PayuResponse(models.Model):
#     pedido = models.ForeignKey(Pedido, related_name='response_pedido', blank=True, null=True)
#     state_pol = models.CharField(max_length=32, blank=True, null=True)
#     response_code_pol = models.CharField(max_length=250, blank=True, null=True)
#     response_message_pol = models.CharField(max_length=250, blank=True, null=True)
#     reference_pol = models.CharField(max_length=255, blank=True, null=True)
#     respuesta = models.CharField(max_length=255, blank=True, null=True)
#
#     phone = models.CharField(max_length=250, blank=True, null=True)
#     additional_value = models.CharField(max_length=250, blank=True, null=True)
#     test = models.CharField(max_length=200, blank=True, null=True)
#     transaction_date = models.CharField(max_length=60, blank=True, null=True)
#     cc_number = models.CharField(max_length=250, blank=True, null=True)
#     cc_holder = models.CharField(max_length=150, blank=True, null=True)
#     error_code_bank = models.CharField(max_length=255, blank=True, null=True)
#     billing_country = models.CharField(max_length=20, blank=True, null=True)
#
#     bank_referenced_name = models.CharField(max_length=250, blank=True, null=True)
#     description = models.CharField(max_length=250, blank=True, null=True)
#     administrative_fee_tax = models.CharField(max_length=150, blank=True, null=True)
#     value = models.CharField(max_length=150, blank=True, null=True)
#     administrative_fee = models.CharField(max_length=120, blank=True, null=True)
#     payment_method_type = models.CharField(max_length=250, blank=True, null=True)
#     office_phone = models.CharField(max_length=60, blank=True, null=True)
#     email_buyer = models.CharField(max_length=250, blank=True, null=True)
#     error_message_bank = models.CharField(max_length=255, blank=True, null=True)
#     shipping_city = models.CharField(max_length=100, blank=True, null=True)
#     transaction_id = models.CharField(max_length=150, blank=True, null=True)
#     sign = models.CharField(max_length=255, blank=True, null=True)
#     tax = models.CharField(max_length=150, blank=True, null=True)
#     payment_method = models.CharField(max_length=250, blank=True, null=True)
#     billing_address = models.CharField(max_length=255, blank=True, null=True)
#     payment_method_name = models.CharField(max_length=255, blank=True, null=True)
#     pse_bank = models.CharField(max_length=255, blank=True, null=True)
#     date = models.CharField(max_length=150, blank=True, null=True)
#     nickname_buyer = models.CharField(max_length=150, blank=True, null=True)
#     reference_pol = models.CharField(max_length=255, blank=True, null=True)
#     currency = models.CharField(max_length=5, blank=True, null=True)
#     risk = models.CharField(max_length=255, blank=True, null=True)
#
#     shipping_address = models.CharField(max_length=255, blank=True, null=True)
#     bank_id = models.CharField(max_length=255, blank=True, null=True)
#     payment_request_state = models.CharField(max_length=100, blank=True, null=True)
#
#     customer_number = models.CharField(max_length=250, blank=True, null=True)
#     administrative_fee_base = models.CharField(max_length=250, blank=True, null=True)
#
#     attempts = models.CharField(max_length=250, blank=True, null=True)
#
#     merchant_id = models.CharField(max_length=150, blank=True, null=True)
#     exchange_rate = models.CharField(max_length=150, blank=True, null=True)
#
#     shipping_country = models.CharField(max_length=250, blank=True, null=True)
#     installments_number = models.CharField(max_length=120, blank=True, null=True)
#     franchise = models.CharField(max_length=150, blank=True, null=True)
#
#     payment_method_id = models.CharField(max_length=150, blank=True, null=True)
#     extra1 = models.CharField(max_length=255, blank=True, null=True)
#     extra2 = models.CharField(max_length=255, blank=True, null=True)
#     antifraudMerchantId = models.CharField(max_length=250, blank=True, null=True)
#     extra3 = models.CharField(max_length=255, blank=True, null=True)
#     nickname_seller = models.CharField(max_length=150, blank=True, null=True)
#
#     ip = models.CharField(max_length=160, blank=True, null=True)
#     airline_code = models.CharField(max_length=120, blank=True, null=True)
#     billing_city = models.CharField(max_length=250, blank=True, null=True)
#     pse_reference1 = models.CharField(max_length=250, blank=True, null=True)
#     reference_sale = models.CharField(max_length=250, blank=True, null=True)
#     pse_reference3 = models.CharField(max_length=250, blank=True, null=True)
#     pse_reference2 = models.CharField(max_length=250, blank=True, null=True)
#     created = models.DateTimeField(editable=False, auto_now_add=True, blank=True)
#
#     class Meta:
#         verbose_name = "Payu Response"
#         verbose_name_plural = "Payu Responses"
#
#     def __unicode__(self):
#         return u"Payu Response: {}".format(self.response_code_pol)


class PagoEfectivoData(models.Model):
    id_moneda = models.CharField(max_length=50, default="1")
    total = models.CharField(max_length=50, blank=True, null=True)
    metodos_pago = models.CharField(max_length=50, default="1,2")
    cod_transaccion = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=100, blank=True, null=True)
    usuarionombres = models.CharField(max_length=100, blank=True, null=True)
    usuarioapellidos = models.CharField(max_length=100, blank=True, null=True)
    usuario = models.CharField(max_length=200, blank=True, null=True)
    concepto_pago = models.CharField(
        max_length=50, default="Compra en Tienda Virtual")
    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)
    enviado = models.BooleanField(default=True)

    class Meta:
        verbose_name = "PagoEfectivo Data"
        verbose_name = "PagoEfectivo Data"

    def __unicode__(self):
        return self.cod_transaccion
