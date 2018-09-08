# -*- coding: utf-8 -*-
from django.conf import settings
from django.contrib import admin
from django.contrib.sites.models import Site
from django.contrib.auth.models import Group
from apps.pedidos.models import (
    Pedido,
    DetallePedido,
    CodigosDeDescuento,
    PaypalInfo,
    PagoEfectivoData
    # PayuResponse,
)
from singlemodeladmin import SingleModelAdmin
from filebrowser.settings import ADMIN_THUMBNAIL
from paypal.standard.pdt.models import PayPalPDT
from apps.core.actions import export_as_csv_action
# from apps.core.templatetags.thumbnail import thumbnail_by_name
# from apps.catalogo.actions import export_pedido_as_pdf

from django import forms

STATIC_URL = settings.STATIC_URL

js_external = [
    '{0}js/external_admin_fixes.js?prod=true'.format(STATIC_URL)
]

from modeltranslation.admin import TranslationAdmin, TranslationStackedInline, TranslationTabularInline
class TranslationAdmin(TranslationAdmin):
    class Media:
        js = js_external


# tinymce
STATIC_URL = settings.STATIC_URL

class DetallePedidoInline(admin.TabularInline):
    model = DetallePedido
    extra = 0
    fields = ['producto_codigo', 'producto_nombre', 'producto_marca', 'producto_precio', 'cantidad', 'importe' ]

    readonly_fields = ['producto_codigo', 'producto_nombre', 'producto_marca', 'producto_precio', 'cantidad', 'importe' ]

# class PayuResponseInline(admin.StackedInline):
#     model = PayuResponse
#     extra = 0
#
#     def get_readonly_fields(self, request, obj=None):
#         result = list(set(
#                 [field.name for field in self.opts.local_fields] +
#                 [field.name for field in self.opts.local_many_to_many]
#             ))
#         result.remove('id')
#         return result

#ccontenidos
class PedidoAdmin(admin.ModelAdmin):
    model = Pedido
    inlines = [DetallePedidoInline
            #    , PayuResponseInline
               ]
    list_display = ['codigo','_get_estado', 'metodopago', 'usuario_nombres',
                    'usuario_apellidos',
                    # 'usuario_dni',
                    'factura_tipo', 'created', 'monto_total', 'cip']

    fieldsets = (
        (u'Información General',{'fields':('created','codigo')}),
        (u'Información de Estado y Descuento',{'fields':('status_info','desc_cod','desc_num')}),
        ('Estado de Pedido',{'fields':('status','status_pagado','metodopago',)}),
        (u'Información de Pago',{'fields':('monto_totalcompra','monto_descuento','monto_delivery', 'monto_total','monto_tasacambio','monto_dolares')}),
        # (u'Detalle de Envío de Pedido',{'fields':('envio_id','envio_nombres','envio_telefono','envio_direccion','envio_distrito','envio_distrito_nombre',
        #                 'envio_provincia_nombre','envio_region_nombre','envio_referencia','factura_tipodocumento')}),

        (u'Información de Facturación',{'fields':('factura_tipo','factura_ruc','factura_razonsocial','factura_direccionfiscal')}),
        (u'Información de Usuario',{'fields':('usuario_id','usuario_nombres', 'usuario_apellidos','usuario_email','usuario_telefono',
                                              'usuario_tipodocumento', 'usuario_nrodocumento', 'usuario_pais',)}),
        (u'PagoEfectivo',{'fields':('cip','estado_pago_efectivo', 'fecha_estado_pago_efectivo','token_response',)}),
        # (u'Datos de Envio (Payu)',{'fields':('sendp_signature', 'sendp_accountId', 'sendp_currency','sendp_description',
        #                                   'sendp_amount','sendp_test', 'sendp_buyerEmail','sendp_shippingAddress',
        #                                   'sendp_shippingCity', 'sendp_shippingCountry')})
    )

    def __init__(self, model, admin_site):
        self.readonly_fields = [field.name for field in model._meta.fields]
        super(PedidoAdmin, self).__init__(model, admin_site)

    def _get_estado(self, obj):
        if obj.status == '1':
            return '<span style="color:gray">PENDIENTE</span>'
        if obj.status == '2':
            return '<span style="color:green">PAGADO</span>'
        if obj.status == '3':
            return '<span style="color:#e30421">RECHAZADO</span>'
    _get_estado.allow_tags = True

@admin.register(CodigosDeDescuento)
class CodigosDeDescuentoAdmin(admin.ModelAdmin):
    list_display = ['cod','active','used','onetime','ini','end','pct','num']
    list_editable = ['onetime','num']
    search_fields = ['cod']
    list_filter = ['onetime','ini']

    def get_readonly_fields(self, request, obj=None):
        if obj and obj.cod:
            return ['cod','pct','usedTimes']
        else:
            return []
# admin.site.register(Producto, ProductoAdmin)

@admin.register(PaypalInfo)
class PaypalInfoAdmin(SingleModelAdmin,TranslationAdmin):
    model = PaypalInfo

class PayPalPDTAdmin(admin.ModelAdmin):
    date_hierarchy = 'payment_date'
    fieldsets = (
        (None, {
            "fields":
                ['flag',
                 'flag_info',
                 'txn_id',
                 'txn_type',
                 'payment_status',
                 'payment_date',
                 'transaction_entity',
                 'reason_code',
                 'pending_reason',
                 'mc_gross',
                 'mc_fee',
                 'auth_status',
                 'auth_amount',
                 'auth_exp',
                 'auth_id',
                 ],
        }),
        ("Address", {
            "description": "Dirección de comprador.",
            'classes': ('grp-collapse grp-closed',),
            "fields":
                ['address_city',
                 'address_country',
                 'address_country_code',
                 'address_name',
                 'address_state',
                 'address_status',
                 'address_street',
                 'address_zip',
                 ],
        }),
        ("Comprador", {
            "description": "Información del comprador.",
            'classes': ('grp-collapse grp-open',),
            "fields":
                ['first_name',
                 'last_name',
                 'payer_business_name',
                 'payer_email',
                 'payer_id',
                 'payer_status',
                 'contact_phone',
                 'residence_country'
                 ],
        }),
        ("Empresa  que realiza el cobro (EPCM)", {
            "description": "Información del cobrador (EPCM).",
            'classes': ('grp-collapse grp-open',),
            "fields":
                ['business',
                 'item_name',
                 'item_number',
                 'quantity',
                 'receiver_email',
                 'receiver_id',
                 'custom',
                 'invoice',
                 'memo',
                 ],
        }),
        ("Suscriptor", {
            "description": "Información de suscriptor.",
            'classes': ('grp-collapse grp-closed',),
            "fields":
                ['subscr_id',
                 'subscr_date',
                 'subscr_effective',
                 ],
        }),
        ("Pago recurrente", {
            "description": "Información sobre pago recurrente.",
            "classes": ("collapse",),
            "fields":
                ['profile_status',
                 'initial_payment_amount',
                 'amount_per_cycle',
                 'outstanding_balance',
                 'period_type',
                 'product_name',
                 'product_type',
                 'recurring_payment_id',
                 'receipt_id',
                 'next_payment_date',
                 ],
        }),
        ("Adicional", {
            "description": "Información adicional.",
            "classes": ('grp-collapse grp-closed',),
            "fields":
                ['test_ipn',
                 'ipaddress',
                 'query',
                 'flag_code',
                 'flag_info',
                 ],
        }),
    )
    list_display = ["__unicode__",
                    "flag_info",
                    "invoice",
                    "custom",
                    "payment_status",
                    "created_at",
                    ]
    search_fields = [
                        "txn_id",
                        "invoice",
                        "recurring_payment_id",'first_name',
                        'last_name',
                        'payer_business_name',
                        'payer_email',
                        'payer_id',
                    ]

    def get_readonly_fields(self, request, obj=None):
        # if request.user.is_superuser:
        #   return self.readonly_fields

        # if self.declared_fieldsets:
        #   return flatten_fieldsets(self.declared_fieldsets)
        # else:
        return list(set(
            [field.name for field in self.opts.local_fields] +
            [field.name for field in self.opts.local_many_to_many]
        ))

    def has_add_permission(self, request):
        return False

    # def has_delete_permission(self, request, obj=None):
    #     return False


class PagoEfectivoDataAdmin(admin.ModelAdmin):
    model = PagoEfectivoData


admin.site.unregister(PayPalPDT)
admin.site.register(PayPalPDT, PayPalPDTAdmin)
admin.site.register(Pedido, PedidoAdmin)
admin.site.register(PagoEfectivoData, PagoEfectivoDataAdmin)
