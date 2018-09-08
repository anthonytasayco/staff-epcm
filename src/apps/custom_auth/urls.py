# -*- coding: utf-8 -*-
from django.conf.urls import patterns, url


urlpatterns = patterns('apps.custom_auth.views',
    url(r'^valid-email/$', 'valid_email', name='valid_email'),
    url(r'^valid-email-edit/$', 'valid_email_edit', name='valid_email_edit'),

    url(r'^ingresar/$', 'login_view', name='login'),
    url(r'^salir/$', 'logout', name='logout'),
    url(r'^registro/$', 'registro', name='registro'),

    # RECUPERAR PASSWORD
    url(r'^recuperar-password/$', 'recupera_password', name='recupera_password'),
    url(r'^cambiar-password/(?P<uuid_hash>[-\w]+)/$', 'set_password', name='set_password'),
    url(r'^cambiar-password-ok/$', 'set_password_success', name='set_password_success'),

    # PRIVATE VIEWS
    url(r'^auth/$', 'logged_view', name='logged_view'),

    # MANTENIEMIENTO DE USUARIOS
    url(r'^myaccount/$', 'myaccount', name='myaccount'),

    url(r'^micuenta-datos/$', 'micuenta_datos', name='micuenta_datos'),
    url(r'^micuenta-cambiar-password/$', 'cambiarpassword', name='cambiarpassword'),
    url(r'^micuenta-direcciones/$', 'micuenta_direcciones', name='micuenta_direcciones'),
    url(r'^micuenta-pedidos/$', 'micuenta_pedidos', name='micuenta_pedidos'),
    url(r'^micuenta-pedido/(?P<slug>[-\w]+)/$', 'micuenta_pedidos', name='micuenta_pedidos_detalle'),

    url(r'^micuenta-lista-deseos/$', 'micuenta_listadeseos', name='micuenta_listadeseos'),
    # url(r'^addresses/$', 'addresses', name='addresses'),

    url(r'^micuenta-direcciones-add/$', 'micuenta_direcciones_edit', name='micuenta_direcciones_add'),
    url(r'^micuenta-direcciones-edit/(?P<slug>[-\w]+)/$', 'micuenta_direcciones_edit', name='micuenta_direcciones_edit'),
    url(r'^micuenta-direcciones-del/(?P<slug>[-\w]+)/$', 'micuenta_direcciones_del', name='micuenta_direcciones_del'),

    # url(r'^add-address/$', 'edit_address', name='address_add'),
    # url(r'^edit-address/(?P<slug>[-\w]+)/$', 'edit_address', name='address'),
    # url(r'^del-address/(?P<slug>[-\w]+)/$', 'del_address', name='address_del'),


    # url(r'^orders/$', 'orders', name='orders'),

    url(r'^order-del/(?P<slug>[-\w]+)/$', 'order_del', name='order_del'),


)
urlpatterns += patterns('apps.custom_auth.ajax',
    # AJAX SERVICE
    url(r'^distritos/$', 'distritos', name='distritos'),
    url(r'^provincias/$', 'provincias', name='provincias'),
    url(r'^regiones/$', 'regiones', name='regiones'),

    # url(r'^registro-ajax/$', 'registro', name='registro_ajax'),
    # url(r'^direcciones/$', 'direcciones', name='direcciones'),
    # url(r'^direcciones-delete/$', 'direcciones_delete', name='direcciones_delete'),


)
