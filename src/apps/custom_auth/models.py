# -*- coding: utf-8 -*-
from pbkdf2 import crypt
from logging import getLogger
from uuid import uuid4
import re

from datetime import date
from django.conf import settings
from django.db import models
from apps.core.models import SlugModel


log = getLogger('django')

SECRET_KEY = settings.AUTH_SECRET_KEY
SALT = ''.join(re.findall("[a-zA-Z0-9]+", SECRET_KEY))
NUMERO_DE_ITERACIONES = 500


class Usuario(models.Model):
    is_active = models.BooleanField('¿Activo?', default=True, blank=True)
    last_login = models.DateTimeField('Último Login', blank=True, null=True)
    # dni = models.CharField("Dni", max_length=250, blank=True)
    nombres = models.CharField("Nombres", max_length=250, blank=True)
    apellidos = models.CharField("Apellidos", max_length=250, blank=True)
    email = models.EmailField('Email', blank=True)
    telefono = models.CharField("Telefono", max_length=250, blank=True)
    tipodocumento = models.CharField("tipo documento", max_length=250, blank=True)
    nrodocumento = models.CharField("nro documento", max_length=250, blank=True)
    pais = models.CharField("pais", max_length=250, blank=True)

    # nacimiento = models.DateField('Fecha', default=date.today())
    set_password = models.BooleanField('¿Contraseña encriptada?', default=False)
    password = models.CharField('Contraseña', max_length=255, default='', blank=True)
    uuid_hash = models.CharField('UUID', max_length=36, default='', blank=True,
        help_text='Aleatorio utilizado para recuperar la contraseña')



    # CHOICES_SEXO = [
    #     ('1', 'Masculino'),
    #     ('2', 'Femenino'),
    # ]
    # sexo = models.CharField(max_length=1, choices=CHOICES_SEXO, default='1', verbose_name='sexo')

    # tipo_documento = models.CharField("Tipo de Documento", max_length=1,
    #     choices=TIPO_DOCUMENTO_CHOICES)


    def __unicode__(self):
        return unicode(self.email)

    class Meta:
        verbose_name = u'Cliente'
        verbose_name_plural = u'Clientes'

    def save(self, *args, **kwargs):
        if not self.uuid_hash:
            self.uuid_hash = str(uuid4())

        if not self.set_password:
            self.password = encrypt_password(self.password)
            self.set_password = True

        super(Usuario, self).save(*args, **kwargs)

    def is_password_valid(self, password):
        return is_password_valid(password, self.password)

    def is_authenticated(self):
        return True

    def is_client(self):
        return True

    @property
    def is_staff(self):
        return False


# HELPERS
def encrypt_password(password):
    ''' Encripta la contraseña '''
    return crypt(password, SALT, NUMERO_DE_ITERACIONES)


def is_password_valid(password, encoded):
    ''' Contrasta la contraseña brindada con el valor encriptado '''
    return encrypt_password(password) == encoded


# #----todo el peru-------------------
# #Distrito
#
class Region(models.Model):
    """Regiones"""
    # codigo = models.PositiveSmallIntegerField()
    codigo = models.CharField(max_length=4, blank=True)
    nombre = models.CharField(max_length=40)
    # aux = models.PositiveSmallIntegerField()
    active = models.BooleanField('¿Activo?', default=False, blank=True)
    delivery = models.DecimalField('Delivery', max_digits=14, decimal_places=2, default=0)

    def __unicode__(self):
        return self.nombre

    class Meta:
        verbose_name = u'Región'
        verbose_name_plural = u'Regiones'
        ordering = ['nombre']


class Provincia(models.Model):
    """Provincias"""
    region = models.ForeignKey(Region, related_name='provincias_region')
    # codigo = models.PositiveSmallIntegerField()
    codigo = models.CharField(max_length=4, blank=True)
    nombre = models.CharField(max_length=40)
    active = models.BooleanField('¿Activo?', default=True, blank=True)
    delivery = models.DecimalField('Delivery', max_digits=14, decimal_places=2, default=0)

    class Meta:
        verbose_name_plural = u'Provincias'
        ordering = ['nombre']

    def __unicode__(self):
        return self.nombre


class Distrito(models.Model):
    provincia = models.ForeignKey(Provincia, related_name='distritos_provincia')
    nombre = models.CharField('Nombre', max_length=120)
    codigo = models.CharField('Orden', max_length=10, blank=True)
    active = models.BooleanField('¿Activo?', default=False, blank=True)
    delivery = models.DecimalField('Delivery', max_digits=14, decimal_places=2, default=0)

    def __unicode__(self):
        return self.nombre

    def deliveryrel(self):
        if self.delivery:
            # print 'ceroo'
            return self.delivery
        else:
            if self.provincia.delivery:
                # print 'unoo'
                return self.provincia.delivery
            else:
                # print 'doss'
                return self.provincia.region.delivery

    class Meta:
        verbose_name_plural = u'Distritos'
        ordering = ['nombre']

# ------------direccion------------------
class Direccion(SlugModel):
    # TIPODISTRITO_CHOICES = (
    #     ('1', 'Distritos de Lima'),
    #     ('2', 'Otros'),
    # )
    usuario = models.ForeignKey(Usuario, related_name='direcciones_usuario', null=True)
    nombres = models.CharField("Nombre de direccion", max_length=250, blank=True)
    # apellidos = models.CharField("Apellidos", max_length=250, blank=True)
    # direccion = models.CharField('Direccion', max_length=250)
    telefono = models.CharField('Telefono', max_length=150)
    distrito = models.CharField('Distrito', max_length=150)
    provincia = models.CharField('Provincia', max_length=150)
    region_nombre = models.CharField('Region Nombre', max_length=250, default='')
    provincia_nombre = models.CharField('Provincia Nombre', max_length=150, default='')
    distrito_nombre = models.CharField('Distrito Nombre', max_length=150, default='')

    region = models.CharField('Region', max_length=150)
    ruc = models.CharField('Ruc', max_length=150)
    referencia = models.TextField('Referencia')
    # distrito = models.ForeignKey(Distrito, related_name='distrito_dire', null=True)
    # district = models.ForeignKey(District, related_name='distrito_dire', null=True)

    is_active = models.BooleanField('¿Activo?', default=True, blank=True)

    def __unicode__(self):
        return unicode(self.nombre)

    class Meta:
        verbose_name = u'Direccion'
        verbose_name_plural = u'Direcciones'
        ordering = ['id']

    def distrito_name(self):
        return Distrito.objects.get(pk=int(self.distrito))

    def provincia_name(self):
        return Provincia.objects.get(pk=int(self.provincia))

    def region_name(self):
        return Region.objects.get(pk=int(self.region))



#
# class CuentaBancaria(models.Model):
#     # nombre_cuenta = models.CharField('cuenta nombre', max_length=120)
#     banco_cuenta = models.CharField('banco nombre', max_length=120)
#     titular_cuenta = models.CharField('titular nombre', max_length=120)
#     nombre_cuenta = models.CharField('tipo cuenta', max_length=120)
#     nro_cuenta = models.CharField('nro cuenta', max_length=120)
#     codigo_interbancario = models.CharField('codigo interbancario ', max_length=120)
#     # ruc = models.CharField('ruc ', max_length=120)
#
#     def __unicode__(self):
#         return u'%s' % self.banco_cuenta
