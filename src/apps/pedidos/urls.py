from django.conf.urls import patterns, url


urlpatterns = patterns('apps.pedidos.views',
    # FRONT - END

    # url(r'^producto/(?P<slug>[-\w]+)/$', 'producto', name='productos_detalle'),

    #carrito
    url(r'^carrito/$', 'carrito', name='carrito'),
    url(r'^promotion/(?P<token>[-\w]+)/$', 'promotion', name='promotion'),
    url(r'^dsct\.io$', 'setDescuento', name='setDescuento'),

    # url(r'^carrito_add/$', 'carrito_add', name='carrito_add'),
    # url(r'^carrito_del/$', 'carrito_del', name='carrito_del'),
    # url(r'^carrito_upd/$', 'carrito_upd', name='carrito_upd'),


    url(r'^facturacion/$', 'datos_facturacion', name='datos_facturacion'),
    url(r'^graciascompra_paypal/$', 'graciascompra_paypal', name='graciascompra_paypal'),
    url(r'^graciascompra/$', 'graciascompra', name='graciascompra'),
    url(r'^errorcompra_paypal/$', 'errorcompra_paypal', name='errorcompra_paypal'),

    # url(r'^pago-validar/$', 'payu_validar', name='payu_validar'),
    # url(r'^pago-respuesta/$', 'payu_respuesta', name='payu_respuesta'),
    # url(r'^pago-payu/$', 'payu_exito', name='payu_exito'),
    url(r'^compras/realizar-pago-pagoefectivo-logged/$', 'realizar_pago_pagoefectivo_logged',
        name='realizar_pago_pagoefectivo_logged'),

    # PAGO EFECTIVO

    url(r'^pagoe/savecip-pagoefectivo/$',
        'savecip_pagoefectivo', name='savecip_pagoefectivo'),
    url(r'^pagoe/estadocip-pagoefectivo/$',
        'estadocip_pagoefectivo', name='estadocip_pagoefectivo'),
    url(r'^pagoe/gracias-compra/show-cip$',
        'show_cip', name='show_cip'),
    url(r'^pagoe/gracias-compra/get-token$',
        'get_token', name='get_token'),
    url(r'^post-payment/datos-facturacion/(?P<token>[-\w]+)/$',
        'facturacion', name='facturacion'),
    url(r'^post-payment/gracias_datos/$',
        'gracias_datos', name='gracias_datos'),
)

urlpatterns += patterns('apps.pedidos.ajax',

    # AJAX SERVICE

)
