# -*- coding: utf-8 -*-

from PIL import Image, ImageEnhance

import os
from os.path import exists as file_exists
from exceptions import IOError
from logging import getLogger

from django.conf import settings
from django.template import Library

from apps.core.util.util import fix_path

log = getLogger('django')

register = Library()

# Imagen a usar en caso de no encontrar el archivo
MEDIA_ROOT = fix_path(settings.MEDIA_ROOT)

MEDIA_URL = settings.MEDIA_URL

file_404 = 'no-disponible/no-disponible.png'
url_404 = '{0}{1}'.format(MEDIA_URL, file_404)
img_404 = '{0}{1}'.format(MEDIA_ROOT, file_404)


@register.filter
def thumbnail(file, size='240x240'):
    filename = file.path
    try:
        Image.open(filename)
    except IOError:
        log.warning('::IOError:: {0}'.format(filename))
        filename = img_404
        file.url = url_404
        log.info(filename)
    # Verificando si existe el directorio para el tamaño seleccionado
    directorio = os.path.join(os.path.dirname(filename), size)
    if not os.path.exists(directorio):
        os.mkdir(directorio)

    # definiendo el tamaño
    x, y = [int(x) for x in size.split('x')]

    # definiendo el nombre de la miniatura
    filehead, filetail = directorio, os.path.split(filename)[1]
    miniature_filename = os.path.join(filehead, filetail)

    filehead, filetail = os.path.split(file.url)
    miniature_url = filehead + '/' + size + '/' + filetail

    # si el original ha sido modificado, se elimina la miniatura anterior
    if (os.path.exists(miniature_filename) and
       (os.path.getmtime(filename) > os.path.getmtime(miniature_filename))):
        os.unlink(miniature_filename)

    # si no se ha redimensionado la imagen, ahora se redimensiona
    if not os.path.exists(miniature_filename):
        image = Image.open(filename)

        if (image.size[0] < x):
            x = image.size[0]
        if (image.size[1] < y):
            y = image.size[1]

        img_ratio = float(image.size[0]) / image.size[1]
        # redimensiona manteniendo proporciones
        if x == 0.0:
            x = y * img_ratio
        elif y == 0.0:
            y = x / img_ratio

        thumb_ratio = float(x) / y
        x = int(x)
        y = int(y)

        if(img_ratio > thumb_ratio):
            c_width = x * image.size[1] / y
            c_height = image.size[1]
            originX = image.size[0] / 2 - c_width / 2
            originY = 0
        else:
            c_width = image.size[0]
            c_height = y * image.size[0] / x
            originX = 0
            originY = image.size[1] / 2 - c_height / 2

        cropBox = (originX, originY, originX + c_width, originY + c_height)
        try:
            image = image.crop(cropBox)
        except:
            return '-'
        image.thumbnail([x, y], Image.ANTIALIAS)
        try:
            image.save(miniature_filename, image.format, quality=90,
                optimize=1)
        except:
            image.save(miniature_filename, image.format, quality=90)

    return miniature_url


@register.filter
def thumbnail_with_max_side(file, size='240'):
    # DEPRECATED ??
    try:
        Image.open(file.path)
    except IOError:
        return ''
    # Verificando si existe el directorio para el tamaño seleccionado
    directorio = os.path.join(os.path.dirname(file.path), size)
    if not os.path.exists(directorio):
        os.mkdir(directorio)
    # defining the filename and the miniature filename
    filehead, filetail = os.path.split(file.path)
    filehead = directorio
    basename, format = os.path.splitext(filetail)
    miniature = basename + '_' + size + format
    filename = file.path
    miniature_filename = os.path.join(directorio, miniature)

    filehead, filetail = os.path.split(file.url)
    miniature_url = filehead + '/' + size + '/' + miniature
    if (os.path.exists(miniature_filename) and
       os.path.getmtime(filename) > os.path.getmtime(miniature_filename)):
        os.unlink(miniature_filename)
    # if the image wasn't already resized, resize it
    if not os.path.exists(miniature_filename):
        image = Image.open(filename)
        x, y = 0, 0

        if (image.size[0] < x) or (image.size[1] < y):
            return filehead + '/' + basename + format

        img_ratio = float(image.size[0]) / image.size[1]
        if img_ratio > 1:
            x = int(size)
        else:
            y = int(size)
        # resize but constrain proportions?
        if x == 0.0:
            x = y * img_ratio
        elif y == 0.0:
            y = x / img_ratio

        thumb_ratio = float(x) / y

        x = int(x)
        y = int(y)

        if(img_ratio > thumb_ratio):
            c_width = x * image.size[1] / y
            c_height = image.size[1]
            originX = image.size[0] / 2 - c_width / 2
            originY = 0
            cropBox = (originX, originY, originX + c_width, originY + c_height)
            image = image.crop(cropBox)
        else:
            c_width = image.size[0]
            c_height = y * image.size[0] / x
            originX = 0
            originY = image.size[1] / 2 - c_height / 2
            cropBox = (originX, originY, originX + c_width, originY + c_height)
            image = image.crop(cropBox)

        image.thumbnail([x, y], Image.ANTIALIAS)
        try:
            image.save(miniature_filename, image.format, quality=90,
                       optimize=1)
        except:
            image.save(miniature_filename, image.format, quality=90)

    return miniature_url


class file_(object):
    '''
        Clase que simula ser un "file"
    '''
    def __init__(self, name='', path='', url=''):
        self.name = name
        self.path = path
        self.url = url


@register.filter
def thumbnail_by_name(name, size='240x240'):
    '''
        Obtiene la miniatura en base al nombre del archivo (relativo al
          directorio media)
    '''
    # fake file
    file = file_()
    file.path = os.path.join(MEDIA_ROOT, name)
    file.url = MEDIA_URL + name

    return thumbnail(file, size)

@register.filter
def thumbnail_by_max_size(name, size='240x240'):
    '''
        Obtiene la miniatura en base al nombre del archivo (relativo al
          directorio media)
    '''
    # fake file
    file = file_()
    file.path = os.path.join(MEDIA_ROOT, name)
    file.url = MEDIA_URL + name

    return thumbnail_with_max_side(file, size)

@register.filter
def valid_img(name, pre_url=''):
    log.info('::valid_img::')
    file = file_()
    name = pre_url + name
    file.path = settings.SITE_ROOT + name
    file.url = name

    log.info(file.path)

    if file_exists(file.path):
        return (file.url)
    else:
        return url_404

######################################### MarkWater

def reduce_opacity(im, opacity):
    """Returns an image with reduced opacity."""
    assert opacity >= 0 and opacity <= 1
    if im.mode != 'RGBA':
        im = im.convert('RGBA')
    else:
        im = im.copy()
    alpha = im.split()[3]
    alpha = ImageEnhance.Brightness(alpha).enhance(opacity)
    im.putalpha(alpha)
    return im

def watermark(im, mark, position, opacity=1):
    """Adds a watermark to an image."""
    if opacity < 1:
        mark = reduce_opacity(mark, opacity)
    if im.mode != 'RGBA':
        im = im.convert('RGBA')
    # create a transparent layer the size of the image and draw the
    # watermark in that layer.
    layer = Image.new('RGBA', im.size, (0,0,0,0))
    if position == 'tile':
        for y in range(0, im.size[1], mark.size[1]):
            for x in range(0, im.size[0], mark.size[0]):
                layer.paste(mark, (x, y))
    elif position == 'scale':
        # scale, but preserve the aspect ratio
        ratio = min(
            float(im.size[0]) / mark.size[0], float(im.size[1]) / mark.size[1])
        w = int(mark.size[0] * ratio)
        h = int(mark.size[1] * ratio)
        mark = mark.resize((w, h))
        layer.paste(mark, ((im.size[0] - w) / 2, (im.size[1] - h) / 2))
    else:
        layer.paste(mark, position)
    # composite the watermark with the layer
    return Image.composite(layer, im, layer)

@register.filter
def thumbnail_water_mark(name, size=None):
    # {{ item.imagen.path|thumbnail_water_mark }}
    # {{ item.imagen.path|thumbnail_water_mark:'100x100' }}
    im = Image.open(os.path.join(MEDIA_ROOT, name))
    mark = Image.open(os.path.join(MEDIA_ROOT,'overlay.png' ))
    import hashlib
    new_value_name = hashlib.md5(name.encode("utf")).hexdigest()
    # watermark(im, mark, 'tile', 0.5).show()
    directorio = os.path.join(MEDIA_ROOT, 'markest')
    new_file_os_ubic = os.path.join(directorio, new_value_name+'.png')
    if not os.path.exists(directorio):
        os.mkdir(directorio)
    # si el original ha sido modificado, se elimina la miniatura anterior
    if (os.path.exists(new_file_os_ubic) and
       (os.path.getmtime(os.path.join(MEDIA_ROOT, name)) > os.path.getmtime(new_file_os_ubic))):
        os.unlink(new_file_os_ubic)
    if os.path.exists(new_file_os_ubic):
        if size:
            return thumbnail_by_name('markest/'+new_value_name+'.png',size)
        else:
            return '/media/markest/'+new_value_name+'.png'
    else:
        watermark(im, mark, 'scale', 0.2).save(os.path.join(directorio, new_value_name+'.png'))
        if size:
            return thumbnail_by_name('markest/'+new_value_name+'.png',size)
        else:
            return '/media/markest/'+new_value_name+'.png'
