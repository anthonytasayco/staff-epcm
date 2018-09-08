# -*- coding: utf-8 -*-

# IMPORTS
from datetime import date
from logging import getLogger
from urlparse import urlparse
from django.shortcuts import (render_to_response as render, get_object_or_404, redirect)
from django.template.defaultfilters import safe
#tranlate imports
from ckeditor.fields import RichTextField
from django.conf import settings
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db import models

# from smart_selects.db_fields import ChainedForeignKey
from ..core.models import AuditableModel, SlugModel, PositionModel, wYoutubeGetID
from geoposition.fields import GeopositionField
from filebrowser.fields import FileBrowseField
from killertags import html_to_text as safetxt
from choices import *

# from models_a import *
# from models_b import *
# from models_c import *

log = getLogger('django')

enlace_help_text='''En caso de ser un enlace interno debe empezar con '/'\
<br>Ejemplo: <strong>/nosotros</strong><br> En caso de enlace Externo\
 debe empezar con http o https Ejemplo: <strong>http://</strong>www.ccapudev.com/es/'''

class InfoSite(AuditableModel):
    email = models.CharField('Email de Contacto', blank=True, max_length=128, help_text='separe los correos con comas')
    telefono = models.CharField('Teĺéfono:', max_length=50)
    direccion = models.CharField('Dirección', max_length=120, help_text='''
                                    Ejemplo:<br>Fray Luis de León 752 // San Borja<br>
                                    <strong>Dirección // Distrito</strong>''')

    footer_inf = models.TextField("Información del footer")
    welcome_text = RichTextField(config_name='small', verbose_name='Login text')

    site = models.CharField("URL del sitio", max_length=60, blank=True,
        help_text='Ingrese la url actual del sitio sin el slash final')
    campus = models.URLField("Link a Campus Virtual", blank=True)
    facebook = models.URLField('Facebook', blank=True)
    twitter = models.URLField('Twitter', blank=True)
    linkedin = models.URLField('LinkedIn', blank=True)
    youtube = models.URLField('youtube', blank=True)
    whatsapp = models.CharField("Número de Whatsapp", max_length=50, blank=True)
    instagram = models.URLField('Instagram', blank=True)
    pinterest = models.URLField('Pinterest', blank=True)

    titulo = models.CharField("Título", max_length=40, blank=True,
        help_text='Título base mostrado en los emails a enviar')

    ga = models.CharField('Google Analytics', max_length=24, blank=True,
       help_text='''Opcional: Inserte el código que google analitycs le
       proporciona con el formato: UA-XXXXX-X''')
    coordenadas = GeopositionField()
    favi57 = FileBrowseField('Favicon 57px', max_length=200,
        directory='favi', extensions=['.jpg', '.png', '.gif'], blank=True)
    favi72 = FileBrowseField('Favicon 72px', max_length=200,
        directory='favi', extensions=['.jpg', '.png', '.gif'], blank=True)
    favi114 = FileBrowseField('Favicon 114px', max_length=200,
        directory='favi', extensions=['.jpg', '.png', '.gif'], blank=True)
    favi256 = FileBrowseField('Favicon 256px', max_length=200,
        directory='favi', extensions=['.jpg', '.png', '.gif'], blank=True)

    def __unicode__(self):
        return u'Información del Sitio'

    class Meta:
        verbose_name_plural = u'Información del Sitio'

    def save(self, *args, **kwargs):
        site = Site.objects.get(id=settings.SITE_ID)
        site.domain = urlparse(self.site).netloc
        site.name = settings.PROJECT_NAME
        site.save()

        if not self.titulo:
            self.titulo = settings.PROJECT_NAME

        super(InfoSite, self).save(*args, **kwargs)


##### Web
class Sliders(AuditableModel):
    posicion = models.PositiveIntegerField('Posición', default=1)
    titulo = models.CharField("Titulo", max_length=256, help_text='encerrar el texto a resaltar con < >')
    fondo = FileBrowseField('Imagen',max_length=200, directory='sliders/', extensions=['.jpg', '.png'])
    color_filter = models.CharField("Color de Filtro", max_length=50,
                    help_text='tenga en cuenta que el fintro tendrá un 80% de opccidad',default='#00369c')
    enlace = models.CharField('Enlace',max_length=1024, blank=True, help_text=enlace_help_text)
    enlace_text = models.CharField('Texto del Enlace',max_length=360, blank=True)

    class Meta:
        verbose_name = u'item'
        verbose_name_plural = u'Sliders'
        ordering = ['posicion']

    def __unicode__(self):
        return u'Banner - {0}'.format(self.posicion,)

class PorqueElegirnos(AuditableModel):
    icon = FileBrowseField('Icono',max_length=200, directory='xqe_icons/', extensions=['.jpg', '.png'])
    icon_h = FileBrowseField('Icono (hover)',max_length=200, directory='xqe_icons_h/', extensions=['.jpg', '.png'])
    nombre = models.CharField('Nombre', max_length=64)
    descript = models.TextField("Descripción", help_text='encerrar el texto a resaltar con < >')
    enlace = models.CharField('Enlace',max_length=1024, blank=True, help_text=enlace_help_text)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'item'
        verbose_name_plural = u'Porqué elegirnos'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)


class SeccionInferior(models.Model):
    l_img = FileBrowseField('Imagen lateral (Home)',max_length=200,
        directory='inf_sector/', help_text='421x376',
        extensions=['.jpg', '.png'])

    class Meta:
        verbose_name = u'Sector'
        verbose_name_plural = u'Sector Inferior'

    def __unicode__(self):
        return u'Sector Inferior'

# blog
class Blog(models.Model):
    postid = models.CharField("postid", max_length=255, unique=True)
    imagen = models.CharField("imagen", max_length=255, blank=True)
    title = models.CharField('title', max_length=255, blank=True)
    excerpt = models.TextField("excerpt", blank=True)
    link = models.CharField('link',max_length=255, blank=True)
    createdat = models.DateTimeField()

########################################################################################################################
###################################################### Conocenos #######################################################
########################################################################################################################
class Conocenos(models.Model):
    cabecera = models.CharField("Cabacera de sección", max_length=50)
    img =FileBrowseField('Imágen lateral',max_length=200, directory='conocenos/', extensions=['.jpg', '.png'])
    #Información
    qs = RichTextField(config_name='small', verbose_name='Quienes somos')
    pa = RichTextField(config_name='small', verbose_name='Project Academy')
    ms = RichTextField(config_name='small', verbose_name='Misión')
    vs = RichTextField(config_name='small', verbose_name='Visión')
    #VideoInstructivo
    bg_titulo = models.CharField("Título", max_length=50, help_text='use // para separa el texto')
    bg_img =FileBrowseField('Imágen de fondo',max_length=200, directory='bg_fondo/', extensions=['.jpg', '.png'])
    bg_vid = models.URLField("Video de Youtube", max_length=1024, blank=True)
    bg_vid_id = models.CharField("ID de video", max_length=50, blank=True)
    bg_vimeo = models.URLField("Video de Vimeo", max_length=1024, blank=True)
    bg_vimeo_id = models.CharField("ID de Vimeo", max_length=50, blank=True, null=True)
    #ComoFunciona
    cf_descript = RichTextField(config_name='small', verbose_name='Como Funciona')
    cf_img = FileBrowseField('Imagen',max_length=200, directory='comofun/', extensions=['.jpg', '.png'])
    cf_vid = models.URLField("Video de Youtube", max_length=1024, blank=True)
    cf_vid_id = models.CharField("ID de video", max_length=50, blank=True)
    cf_vimeo = models.URLField("Video de Vimeo", max_length=1024, blank=True)
    cf_vimeo_id = models.CharField("ID de Vimeo", max_length=50, blank=True, null=True)
    #NuestroStaff
    ns_titulo = models.CharField("Título", max_length=64)
    ns_descript = RichTextField(config_name='small', verbose_name='Descripción')
    #NosRespaldan
    nr_titulo = models.CharField("Título", max_length=64)
    nr_descript = RichTextField(config_name='small', verbose_name='Descripción')

    def buildVidIdiomas(self):
        import re
        if self.cf_vid:
            self.cf_vid_id = wYoutubeGetID(self.cf_vid_id,self.cf_vid)
            print self.cf_vid_id
        else:
            self.cf_vid_id = ''

        if self.cf_vimeo:
            self.cf_vimeo_id = re.search(r'^(https://)?(www\.)?(vimeo\.com/)?(\d+)', self.cf_vimeo).group(4)
        else:
            self.cf_vimeo_id = ''

        if self.bg_vid:
            self.bg_vid_id = wYoutubeGetID(self.bg_vid_id,self.bg_vid)
            print self.bg_vid_id
        else:
            self.bg_vid_id = ''

        if self.bg_vimeo:
            self.bg_vimeo_id = re.search(r'^(https://)?(www\.)?(vimeo\.com/)?(\d+)', self.bg_vimeo).group(4)
            print self.bg_vimeo_id
        else:
            self.bg_vimeo_id = ''

    def save(self, *args, **kwargs):
        langs = ['es','en','pt']
        from django.utils.translation import get_language, activate
        for l in langs:
            activate(l)
            self.buildVidIdiomas()

        super(Conocenos, self).save(*args, **kwargs)

    def getTestimonios(self):
        return EllosOpinan.objects.active().order_by('posicion')

    def getClientes(self):
        return Clientes.objects.active().order_by('posicion')

    def getPaises(self):
        return Paises.objects.active().order_by('posicion')

    def getRepaldos(self):
        return Respaldos.objects.active().order_by('posicion')

    class Meta:
        verbose_name = u'Conócenos'
        verbose_name_plural = u'Conócenos Sección'

    def __unicode__(self):
        return u'Conócenos Sección'


class Clientes(AuditableModel):
    img = FileBrowseField('Logo',max_length=200, directory='clientes/', extensions=['.jpg', '.png'])
    nombre = models.CharField('Nombre', max_length=256)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'cliente'
        verbose_name_plural = u'Clientes'
        ordering = ['posicion']

    def __unicode__(self):
        return u'Cliente: {0}'.format(self.nombre,)


class EllosOpinan(AuditableModel):
    img = FileBrowseField('Foto',max_length=200, directory='opiniones/', extensions=['.jpg', '.png'])
    nombre = models.CharField('Nombre', max_length=256)
    cargo = models.CharField("Cargo", max_length=128)
    descript = models.TextField("Descripción")
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'persona'
        verbose_name_plural = u'Testimonios'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)


class Respaldos(AuditableModel):
    img = FileBrowseField('Foto',max_length=200, directory='partners/', extensions=['.jpg', '.png'])
    nombre = models.CharField("Nombre", max_length=50)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'respaldo'
        verbose_name_plural = u'Respaldos'
        ordering = ['posicion']

    def __unicode__(self):
        return u'Cliente: {0}'.format(self.nombre,)

class Paises(AuditableModel):
    posicion = models.PositiveIntegerField("Posición", default=1)
    img =FileBrowseField('Bandera',max_length=200, directory='banderas/', extensions=['.jpg', '.png'])
    nombre = models.CharField('Nombre', max_length=64)

    class Meta:
        verbose_name = u'país'
        verbose_name_plural = u'Paises'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)

class ContactoSeccion(models.Model):
    cabecera = models.CharField("Cabecera", max_length=64)
    titulo = models.CharField("Título", max_length=64)
    descript = RichTextField(config_name='small', verbose_name='Descripción')

    class Meta:
        verbose_name = u'Contacto Sección'
        verbose_name_plural = u'Contacto Sección'

    def __unicode__(self):
        return u'Contacto Sección'

class LibroSeccion(models.Model):
    cabecera = models.CharField("Cabecera", max_length=64)
    descript = RichTextField(config_name='small', verbose_name='Descripción')
    pie = RichTextField(config_name='small', verbose_name='Pie de página')

    class Meta:
        verbose_name = u'Lib. de Reclamaciones Sección'
        verbose_name_plural = u'Lib. de Reclamaciones Sección'

    def __unicode__(self):
        return u'Lib. de Reclamaciones Sección'

########################################################################################################################
##################################################### Diccionario ######################################################
########################################################################################################################
from .util import hasherStr
from django.core.cache import cache

class TranslaterDicc(AuditableModel):
    variable = models.CharField('Variable', max_length=520, blank=True,
                                            help_text=''' Esta palabra ("variable") es única y <strong>solo sirve como \
                                            referencia</strong> al texto original en la web.<br>es decir que lo que se \
                                            mostrará en la web será su valor en español o ingles respectivamente ''')
    nombre = models.CharField('Nombre', max_length=520, blank=True,
                            help_text=u'''Recuerde no eliminar la etiquetas [&lt;p&gt;&lt;br&gt;&lt;h1&gt;&lt;h2&gt;] \
                                        o ninguna etiqueta parecida.<br>Al traducir solo coloque las etiquetas \
                                        en una posición relativa al texto Original''')


    def save(self, *args, **kwargs):
        if self._state.adding == False:
            # print(">>>>>>>>>>> Updating Object")
            md5_str = hasherStr(self.variable)
            cache.delete(md5_str+'en')
            cache.delete(md5_str+'es')
            cache.delete(md5_str+'pt')
        super(TranslaterDicc, self).save(*args, **kwargs)

    class Meta:
        verbose_name = u'Palabra'
        verbose_name_plural = u'Diccionario de Traducciones'

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)
