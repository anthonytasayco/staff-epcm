# -*- coding: utf-8 -*-
from apps.core.utils import render_to_pdf


def export_pedido_as_pdf(modeladmin, request, queryset):
    '''
    Acción que permite exportar el detalle de un pedido en formato pdf.
    '''
    #response = HttpResponse(mimetype='application/pdf')
    #response['Content-Disposition'] = 'attachment;\
     #filename=Pedidos.pdf'

    #pdf = PDF()
    #pdf.config()
    #for pedido in queryset:
        #pdf.add_carrito(carrito)

    #response.write(pdf.output('', 'S'))
    result = render_to_pdf('web/respedido_pdf.html',
        {'pagesize': 'A4', 'mylist': 'okey', 'queryset': queryset})

    return result

export_pedido_as_pdf.short_description = 'Exportar Pedido como PDF'
