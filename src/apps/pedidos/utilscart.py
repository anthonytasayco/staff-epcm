# -*- coding: utf-8 -*-
from django.shortcuts import get_object_or_404
from django.contrib import messages
from decimal import Decimal
import random
from apps.web.util import get_info
from apps.custom_auth.models import Direccion, Distrito, Usuario
from apps.pedidos.models import DetallePedido, Pedido
import json
from datetime import datetime, timedelta
from ..cursos.models import Cursos as Producto

# , Pedido, DetallePedido

from logging import getLogger
log = getLogger('django')

# NOTA: el procesamiento del carrito al pedido esta en el modelo pedido:


# obtiene el array del carrito activo
def close_carrito(request):
    request.session['sesioncarrito'] = ''
    request.session['pedido'] = ''
    request.session['dscnt_cod'] = ''
    request.session['dscnt'] = 0

def getlist_carrito(request):
    sesioncarrito = request.session.get('sesioncarrito', '')
    if sesioncarrito == '':
        request.session['sesioncarrito'] = []
        request.session["paypal_pay"] = False
        sesioncarrito = list()
    return sesioncarrito


#---elimina sessiones de carrito y key de direcciones-----------
def carrito_eliminarsesiones(request):
    del request.session['sesioncarrito']
    envio = request.session.get('envio', '')
    if envio != '':
        del request.session['envio']


# -solo para ver el nro Total
def carrito_get_nro(request):
    sesioncarrito = request.session.get('sesioncarrito', '')
    if sesioncarrito == '':
        sesioncarrito = list()
    nro = 0
    for c in sesioncarrito:
        nro += 1
    return nro

# para todas las operaciones de agregado y actualzacion del carrito
def carrito_result(request, operacion = '0', iditem = None, cantitem = None):
    ''' operacion => 0:listar, 1:add, 2:editar, 3:eliminar '''
    sesioncarrito = request.session.get('sesioncarrito', '')
    if sesioncarrito == '':
        request.session['sesioncarrito'] = []
        sesioncarrito = list()

    result = list()
    tmp = list()
    suma = 0
    nro = 0
    n = 0
    if operacion in ['1', '2', '3']:
        request.session['pedido'] = ''
    if operacion == '1':
        add = {'id': '%s' % iditem, 'cantidad': '%s' % cantitem}
        sesioncarrito.append(add)
    # print sesioncarrito

    ubicado_antes = 'no'
    for c in sesioncarrito:
        # log.warning('item carrito: %s' % c)
        n = n + 1
        # print c
        prod = get_object_or_404(Producto, pk=int(c['id']))
        # operaciones ::
        if c['cantidad']:
            cantidad_float = float(c['cantidad'])
        else:
            cantidad_float = 1

        if operacion == '1' and n != len(sesioncarrito):
            if str(c['id']) == str(iditem):
                ubicado_antes = 'si'
                ncantidad = 1
                cantidad_float = float(ncantidad)
        if operacion == '2':
            if str(c['id']) == str(iditem):
                ncantidad = int(cantitem)
                cantidad_float = float(ncantidad)
        itemok = 'si'
        # no tomar en cuenta si:
        if operacion == '1' and n == len(sesioncarrito) and ubicado_antes == 'si':
            itemok = 'no'
        if operacion == '3' and str(c['id']) == str(iditem):
            itemok = 'no'

        if itemok == 'si':
            # solo se agregan los no eliminados
            y = {'id': c['id'], 'cantidad': cantidad_float}
            tmp.append(y)

            if prod.precio:
                precio_float = float(prod.precio)
            else:
                precio_float = 0

            total = precio_float * cantidad_float
            suma = suma + total
            try:
                imagen = prod.img.url
            except:
                imagen = ''

            x = {
                'id': c['id'],
                'cantidad': int(cantidad_float),
                'nombre': prod.nombre,
                'codigo': prod.cod,

                'slug': prod.slug,
                'fechas':prod.fechas,
                'horarios':prod.horarios,
                'lugar':prod.lugar,
                'inversion':prod.inversion,
                # 'marca' : prod.marca.nombre,
                # 'color': prod.color,
                # 'labelcolor': labelcolor,

                # 'rstock': rstock,
                # 'rangestock': prod.rangestock,
                # 'orden': n-1,
                'imagen': imagen,
                'pu': float(prod.precio),
                # 'descuento': descuento,
                'pt': total,
                }
            result.append(x)
            nro += int(cantidad_float)

    request.session['sesioncarrito'] = tmp
    return (result, suma, n, nro)
