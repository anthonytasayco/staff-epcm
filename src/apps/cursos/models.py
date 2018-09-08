# -*- coding: utf-8 -*-

# IMPORTS
from uuid import uuid4
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

from smart_selects.db_fields import ChainedForeignKey, ChainedManyToManyField
from ..core.models import AuditableModel, SlugModel, PositionModel, wYoutubeGetID
from geoposition.fields import GeopositionField
from filebrowser.fields import FileBrowseField
from killertags import html_to_text as safetxt, name_cleaner
from choices import *

# from models_a import *
# from models_b import *
# from models_c import *

log = getLogger('django')

tabla_def='''
<table border="1" cellpadding="0" cellspacing="0" style="width:580px">
    <thead>
        <tr>
            <th scope="col">&nbsp;</th>
            <th scope="col">&nbsp;</th>
            <th scope="col">&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </tbody>
</table>

<p>&nbsp;</p>

'''

enlace_help_text='''En caso de ser un enlace interno debe empezar con '/'\
<br>Ejemplo: <strong>/nosotros</strong><br> En caso de enlace Externo\
 debe empezar con http o https Ejemplo: <strong>http://</strong>www.ccapudev.com/es/'''

sf_strg = 'encerrar el texto a resaltar con < >'

class CursosDeInteres(models.Model):
    titulo = models.CharField("Título", max_length=50)
    detalle = models.CharField("Detalle", max_length=50)

    def getCursos(self):
        return Cursos.objects.filter(de_interes=True).order_by('-inicio')[:12]

    class Meta:
        verbose_name = u'Cursos de Interés'
        verbose_name_plural = u'Cursos de Interés'

    def __unicode__(self):
        return u'Cursos de Interés'


class CursosCategorias(AuditableModel,SlugModel):
    nombre = models.CharField('Nombre', max_length=256)
    descript = RichTextField(config_name='small', verbose_name='Dirigido a')
    img_s =FileBrowseField('Imágen Superior',max_length=200, directory='cursecc_sup/',
                            extensions=['.jpg', '.png'], blank=True)
    img_i =FileBrowseField('Imágen Inferior',max_length=200, directory='cursecc_inf/',
                            extensions=['.jpg', '.png'], blank=True)
    # categoria = models.ManyToManyField(CursosCategorias, blank=True)
    # idiomas = models.ManyToManyField(Idiomas, blank=True)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'categoría'
        verbose_name_plural = u'Categorías de Cursos'
        ordering = ['posicion']

    def getRubros(self):
        return Rubros.objects.active().filter(categoria=self).order_by('posicion')
        # return self.rubros.all()

    def getIdiomas(self):
        return Idiomas.objects.active().filter(categoria=self).order_by('posicion')

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)


class Idiomas(AuditableModel,SlugModel):
    nombre = models.CharField('Nombre', max_length=256)
    categoria = models.ManyToManyField(CursosCategorias, blank=True)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'idioma'
        verbose_name_plural = u'Idiomas'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)

class Rubros(AuditableModel,SlugModel):
    nombre = models.CharField('Nombre', max_length=256)
    categoria = models.ManyToManyField(CursosCategorias, blank=True)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'rubro'
        verbose_name_plural = u'Rubros'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)


class Cursos(AuditableModel,SlugModel):
    relacion = models.ForeignKey("self",related_name="cursos_relacionados", null=True, blank=True,
        help_text='los cursos que tengan este campo vació apareceran \
         por defecto. los demas cursos deberan ser relacionados con su respectivo \
         representante')
    categoria = models.ForeignKey(CursosCategorias)
    # rubro = models.ManyToManyField(Rubros, blank=True)
    # idiomas = models.ManyToManyField(Idiomas, blank=True)
    rubro = ChainedManyToManyField(
            Rubros,
            chained_field="categoria",
            chained_model_field="categoria"
        )
    idiomas = ChainedManyToManyField(
            Idiomas,
            chained_field="categoria",
            chained_model_field="categoria"
        )
    posicion = models.PositiveIntegerField("Posición", default=1)
    nombre = models.CharField('Nombre', max_length=256)
    nombre_complex = models.CharField('Nombre', max_length=256, help_text='encierre el texto a resaltar con < >')
    img =FileBrowseField('Imágen de Curso',max_length=200, directory='cursos/', extensions=['.jpg', '.png'])
    #Categorización
    de_interes = models.BooleanField("Curso de interes", default=False)
    nuevo = models.BooleanField("Nuevo", default=False)
    online = models.BooleanField("Online", default=False)
    classroom = models.BooleanField("Classroom", default=False)
    webcast = models.BooleanField("Live WebCast", default=False)

    #Información
    inicio = models.DateField("Fecha de inicio", default=date.today)
    descript = RichTextField(config_name='small', verbose_name='Descripción')
    yt_img_usage = models.BooleanField("Usar miniatura del Youtube como imagen de curso", default=False)

    video = models.URLField("Video de Youtube", max_length=1024, blank=True)
    video_id = models.CharField("Video de Youtube", max_length=1024, blank=True)

    vimeo = models.URLField("Video de Vimeo", max_length=1024, blank=True)
    vimeo_id = models.CharField("ID de Vimeo", max_length=50, blank=True, null=True)

    archivo = models.FileField('Brochure',upload_to='brochures/%Y/%m/%d/', blank=True)
    fechas = models.CharField("Fechas", max_length=256)
    horarios = models.CharField("Horarios", max_length=256)
    lugar = models.CharField("Lugar", max_length=256)
    inversion = models.CharField("Inversión", max_length=256)
    #Meotodología y Docentes
    mt_show = models.BooleanField("Mostrar Metodología", default=True)
    mt_titulo = models.CharField("Título de Metodología", max_length=64, help_text='NUESTRA &lt;METODOLOGIA&gt;', blank=True)
    mt_descript = RichTextField(config_name='small', verbose_name='Meotodología', blank=True)
    dc_titulo = models.CharField("Título de Docentes", max_length=64, help_text='NUESTROS &lt;DOCENTES&gt;', blank=True)
    dc_descript = RichTextField(config_name='small', verbose_name='Docentes', blank=True)
    #Inversión
    iv_show = models.BooleanField("Mostrar inversión", default=True)
    iv_descript = RichTextField(config_name='small', verbose_name='Descripción de Inversión', blank=True)
    iv_tabla = RichTextField(config_name='default', verbose_name='Tabla de Inversión', blank=True, default=tabla_def)
    iv_descript_pie = RichTextField(config_name='small', verbose_name='Pie de tabla de Inversión', blank=True)
    #Demo
    dm_show = models.BooleanField("Mostrar Demo", default=True)
    dm_titulo = models.CharField("Título", max_length=64, help_text='COURSE &lt;DEMO QUIZ&gt;', blank=True)
    dm_descript = RichTextField(config_name='small', verbose_name='Descripción de Demo', blank=True)
    dm_video = models.URLField("Video de Youtube", max_length=1024, blank=True)
    dm_video_id = models.CharField("ID Video de Youtube", max_length=1024, blank=True)

    #PayInfo
    cod = models.CharField("Codigo de curso", max_length=32, blank=True)
    # precio = models.PositiveIntegerField("Precio de curso", default=69)
    precio = models.DecimalField("Precio", max_digits=6, decimal_places=2, default=69)

    class Meta:
        verbose_name = u'curso'
        verbose_name_plural = u'Cursos'
        ordering = ['posicion']

    def getImg(self):
        if self.yt_img_usage and self.video_id:
            return 'https://img.youtube.com/vi/{0}/hqdefault.jpg'.format(self.video_id,)
        elif self.img:
            return self.img.url
        else:
            return ''

    def getDemoImg(self):
        if self.dm_video and self.dm_video_id:
            return 'https://img.youtube.com/vi/{0}/hqdefault.jpg'.format(self.video_id,)
        elif self.img:
            return self.img.url
        else:
            return ''

    def getModalidad(self):
        response = ''
        if self.online:
            response += ' Online'
        if self.classroom:
            response += ' Classroom'
        if self.webcast:
            response += ' Live WebCast'

        return response

    def getIdiomas(self):
        arr = []
        for row in self.idiomas.all():
            arr.append(row.nombre)
        return ', '.join(arr,)

    def getRubros(self):
        arr = []
        for row in self.rubro.all():
            arr.append(row.nombre)

        return ', '.join(arr,)

    def save(self, *args, **kwargs):
        import re
        if self.video:
            self.video_id = wYoutubeGetID(self.video_id,self.video)
            print self.video_id
        else:
            self.video_id = ''

        if self.dm_video:
            self.dm_video_id = wYoutubeGetID(self.dm_video_id,self.dm_video)
            print self.dm_video_id
        else:
            self.dm_video_id = ''
        if not self.cod:
            self.cod = str(uuid4())[:8]

        if self.vimeo:
            self.vimeo_id = re.search(r'^(https://)?(www\.)?(vimeo\.com/)?(\d+)', self.vimeo).group(4)
        else:
            self.vimeo_id = ''

        super(Cursos, self).save(*args, **kwargs)

    def getContenidos(self):
        return Contenidos.objects.active().filter(curso=self).order_by('posicion')


    def getBeneficios(self):
        return Beneficios.objects.active().filter(curso=self).order_by('posicion')


    def getProfesores(self):
        return Profesores.objects.active().filter(cursos=self).order_by('posicion')


    def __unicode__(self):
        return u'{0}'.format(self.nombre,)

class Contenidos(AuditableModel):
    curso = models.ForeignKey(Cursos)
    nombre = models.CharField('Nombre', max_length=256)
    descript = RichTextField(config_name='small', verbose_name='Descripción')
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'contenido'
        verbose_name_plural = u'Contenidos de Curso'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)

class Beneficios(AuditableModel):
    curso = models.ForeignKey(Cursos)
    nombre = models.CharField('Nombre', max_length=256)
    descript = RichTextField(config_name='small', verbose_name='Descripción')
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'Beneficio'
        verbose_name_plural = u'Beneficios de Curso'
        ordering = ['posicion']

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)



class Profesores(AuditableModel,SlugModel):
    cursos = models.ManyToManyField(Cursos)
    img =FileBrowseField('Foto',max_length=200, directory='teachers/', extensions=['.jpg', '.png'])
    nombres = models.CharField('Nombres', max_length=128)
    apellidos = models.CharField("Apellidos", max_length=128)
    detalle = models.CharField("Detalle", max_length=50, help_text='va despues de la coma "CCE"')
    cargo = models.CharField("Titulo o Cargo", max_length=128, help_text='Profesional certificado como CCP')
    descript = RichTextField(config_name='small', verbose_name='Descripción')
    descript_simple = models.TextField("Descripción ligera", blank=True,
                                        help_text='esta descripción sale en Conócenos')
    linkedin = models.URLField("Linkedin", blank=True)
    posicion = models.PositiveIntegerField("Posición", default=1)

    class Meta:
        verbose_name = u'Profesor'
        verbose_name_plural = u'Profesores'
        ordering = ['posicion']

    @property
    def nombre(self):
        return u'{0}, {1}'.format(self.nombres,self.apellidos)

    def __unicode__(self):
        return u'{0}'.format(self.nombre,)
