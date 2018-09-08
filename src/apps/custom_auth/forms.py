# -*- coding: utf-8 -*-
from logging import getLogger

from django import forms
from django.contrib.auth import authenticate
from django.contrib.sites.models import Site
from django.core.mail import EmailMessage
from django.core.urlresolvers import reverse
from django.template import Context
from django.template.loader import get_template
from django.conf import settings
from django.contrib import messages
from apps.web.util import get_info
from django.http import HttpResponseRedirect
from django.utils.safestring import mark_safe

from .models import Usuario, Direccion, Distrito, Region, Provincia, Distrito
global STATIC_URL, MEDIA_URL
STATIC_URL = settings.STATIC_URL
MEDIA_URL = settings.MEDIA_URL
EMAIL_DEVELOPER = settings.EMAIL_DEVELOPER

log = getLogger('django')
#----------mas fomrmularios -----------


class RegistroForm(forms.Form):
    ''' Formulario de Registro '''
    nombres = forms.CharField(label='nombres')
    nombres.widget.attrs.update({'placeholder': 'nombres', 'class': 'input-car'})
    telefono = forms.CharField(label='nombres', required=False)
    telefono.widget.attrs.update({'placeholder': 'telefono', 'class': 'input-car'})
    apellidos = forms.CharField(label='apellidos', required=False)
    # apellidos.widget.attrs.update({'placeholder': 'apellidos', 'class': 'input-car', 'tabindex' :'2'})
    username = forms.EmailField(label='Email')
    username.widget.attrs.update({'placeholder': 'email', 'class': 'input-car'})
    # dni = forms.CharField(label='Dni')
    # sexo = forms.CharField(label='Sexo', required=False)
    username.widget.attrs.update({'placeholder': 'email', 'class': 'input-car'})
    password = forms.CharField(label='Contraseña', min_length=7,
        max_length=32, widget=forms.PasswordInput)
    password.widget.attrs.update({'placeholder': 'contraseña', 'class': 'input-car '})
    # repassword = forms.CharField(label='Contraseña', min_length=7,
    #     max_length=32, widget=forms.PasswordInput)
    # repassword.widget.attrs.update({'placeholder': 'repetir contraseña', 'class': 'input-car', 'tabindex' :'5'})
    nexturl = forms.CharField(required=False, widget=forms.HiddenInput(), initial='')

    def clean_username(self):
        username = self.cleaned_data['username']
        try:
            Usuario.objects.get(email=username)
            mensaje = (mark_safe(u'El email ya ha sido registrado.  '))
            raise forms.ValidationError(mensaje)
        except Usuario.DoesNotExist:
            return username
        return username

    def save(self):
        cd = self.cleaned_data
        Usuario(email=cd['username'],password=cd['password'], nombres=cd['nombres'],
                apellidos=cd['apellidos'], telefono=cd['telefono']).save()

    def auth(self):
        cd = self.cleaned_data
        return authenticate(username=cd['username'], password=cd['password'])

    def enviaEmail(self):
        htmly = get_template('email/bienvenida.html')
        site = Site.objects.get(id=settings.SITE_ID)
        cd = self.cleaned_data

        info = get_info()
        infosite = info.site
        # url = reverse('custom_auth:set_password', kwargs={'uuid_hash':self.u.uuid_hash})


        cd['urlweb'] = '%s' % (infosite)
        cd['SITE'] = site.domain
        cd['STATIC_URL'] = infosite + STATIC_URL
        try:
            self.u = Usuario.objects.get(email=cd['username'])
            cd['usuario'] = self.u
            emailsend = self.u.email
        except:
            emailsend = ''
        d = Context(cd)

        html_content = htmly.render(d)
        asunto = u'Want'
        mail = '{0}<{1}>'.format(settings.PROJECT_NAME,
            settings.DEFAULT_FROM_EMAIL)
        msg = EmailMessage(asunto, html_content, mail, [emailsend])
        msg.content_subtype = "html"
        msg.send()

class DireccionDeleteForm(forms.Form):
    '''
        Formulario de elimiacion de direcciones
    '''
    id = forms.CharField(required=False, widget=forms.HiddenInput(), initial=0)
    # -------------basicos

    direccion = forms.CharField(label='Direccion')
    direccion.widget.attrs.update({'placeholder': '', 'class': ''})

    def delete(self):
        cd = self.cleaned_data
        ida = cd['id']
        direccion = cd['direccion']
        Direccion.objects.get(pk=ida, direccion=direccion).delete()


class EditUsuarioForm(forms.Form):
    '''
        Formulario de Registro Usuario Base
    '''
    # id = forms.CharField(required=False, widget=forms.HiddenInput(), initial=0)
    # -------------basicos
    nombres = forms.CharField(label='Nombres', required=False)
    pais = forms.CharField(label='País', required=False)
    sexo = forms.CharField(label='Sexo', required=False)
    nrodocumento = forms.CharField(label='Nro de Documento', required=False)
    telefono = forms.CharField(label='nombres', required=False)
    email = forms.EmailField(label='Email', required=False)

    def clean(self):
        cd = self.cleaned_data
        if 'email' in cd and 'id' in cd:
            ida = cd['id']  # id de usuario
            email = cd['email']
            try:
                Usuario.objects.exclude(pk=int('0' + ida)
                ).exclude(is_active=False).get(email__iexact=email)
                mensaje = (u'El email ya ha sido registrado ')
                raise forms.ValidationError(mensaje)
            except Usuario.DoesNotExist:
                return cd
        return cd

    def update(self, pk):
        cd = self.cleaned_data
        row = Usuario.objects.get(pk=pk)
        fields = ['nombres', 'telefono', 'email', 'nrodocumento', 'pais', 'sexo']
        for f in fields:
            row.__dict__[f] = cd[f]
        row.save()
        return row



#----------------
class LoginForm(forms.Form):
    ''' Formulario de acceso al sistema '''
    username = forms.CharField(label='Email', min_length=7,)
    username.widget.attrs.update({'placeholder': 'Correo:', 'class': ''})
    password = forms.CharField(label='Contraseña', min_length=7,
        max_length=32, widget=forms.PasswordInput)
    password.widget.attrs.update({'placeholder': 'Contraseña:', 'class': ''})

    # def clean_username(self):
    #     username = self.cleaned_data['username']
    #     try:
    #         Usuario.objects.get(email=username)
    #     except Usuario.DoesNotExist:
    #         mensaje = u'El email no ha sido registrado'
    #         raise forms.ValidationError(mensaje)
    #
    #     return username

    def auth(self):
        cd = self.cleaned_data
        return authenticate(username=cd['username'], password=cd['password'])

class RecuperaPasswordForm(forms.Form):
    '''
        Formulario que solicita el email para iniciar el proceso de
        recuperación de contraseña.
    '''
    username = forms.EmailField(label='Email')
    username.widget.attrs.update({'placeholder': 'Correo', 'class': 'validate[required,custom[email]]'})

    def clean_username(self):
        username = self.cleaned_data['username']

        try:
            self.u = Usuario.objects.get(email=username)
        except Usuario.DoesNotExist:
            mensaje = 'El email no ha sido registrado'
            raise forms.ValidationError(mensaje)

        return username

    def enviaEmail(self):
        htmly = get_template('custom_auth/password/email-setpassword.html')
        site = Site.objects.get(id=settings.SITE_ID)
        cd = self.cleaned_data

        info = get_info()
        infosite = info.site
        url = reverse('custom_auth:set_password', kwargs={'uuid_hash':self.u.uuid_hash})

        cd['enlace'] = '%s%s' % (infosite, url)
        cd['enlace'] = cd['enlace'].replace('www.', 'https://')
        cd['SITE'] = site.domain
        cd['STATIC_URL'] = infosite + STATIC_URL
        cd['usuario'] = self.u
        d = Context(cd)

        html_content = htmly.render(d)
        asunto = u'Actualización de Contraseña'
        mail = '{0}<{1}>'.format(settings.PROJECT_NAME,
            settings.DEFAULT_FROM_EMAIL)
        msg = EmailMessage(asunto, html_content, mail, [self.u.email])
        msg.content_subtype = "html"
        msg.send()


class SetPasswordForm(forms.Form):
    uuid_hash = forms.CharField(label='', widget=forms.HiddenInput)
    email = forms.EmailField(label='Email', widget=forms.HiddenInput)
    email.widget.attrs.update({ 'class': 'input-car', 'readonly': 'readonly'})
    password = forms.CharField(label='Nueva contraseña', min_length=7,
        max_length=32, widget=forms.PasswordInput)
    password.widget.attrs.update({'placeholder': 'contraseña', 'class': 'input-car'})

    def clean_email(self):
        uuid_hash = self.cleaned_data['uuid_hash']
        email = self.cleaned_data['email']
        try:
            self.u = Usuario.objects.get(email=email, uuid_hash=uuid_hash)
        except Usuario.DoesNotExist:
            raise forms.ValidationError('El email o la clave temporal son' +
                'incorrectos!')

        return email

    def save(self):
        cd = self.cleaned_data
        usuario = self.u
        usuario.set_password = False
        usuario.uuid_hash = ''
        usuario.password = cd['password']
        usuario.save()


    def enviaEmail(self):
        htmly = get_template('custom_auth/password/email-password-update.html')
        site = Site.objects.get(id=settings.SITE_ID)
        info = get_info()
        infosite = info.site
        cd = self.cleaned_data
        # url = reverse('custom_auth:set_password', kwargs={'uuid_hash':self.u.uuid_hash})
        #
        # cd['enlace'] = '%s%s' % (infosite, url)

        cd['SITE'] = infosite
        cd['STATIC_URL'] = infosite + STATIC_URL
        cd['usuario'] = self.u
        d = Context(cd)

        html_content = htmly.render(d)
        asunto = u'Actualización de Contraseña'
        mail = '{0}<{1}>'.format(settings.PROJECT_NAME,
            settings.DEFAULT_FROM_EMAIL)
        msg = EmailMessage(asunto, html_content, mail, [self.u.email])
        msg.content_subtype = "html"
        msg.send()


class DireccionForm(forms.Form):
    '''
        Formulario de Registro Usuario Base
    '''
    ida = forms.CharField(required=False, widget=forms.HiddenInput(), initial=0)
    nombres = forms.CharField(label='Nombres')
    nombre = forms.CharField(label='Direccion', required=False)
    region = forms.CharField(label='Departamento')
    provincia = forms.CharField(label='Provincia')
    distrito = forms.CharField(label='Distrito')
    telefono = forms.CharField(label='Telefono', required=False)
    referencia = forms.CharField(label='Referencia',
                                  widget=forms.Textarea(attrs={'rows': 4, 'placeholder': 'Referencia', 'class':'validate[required]'}))

    def save(self, request):
        cd = self.cleaned_data
        ida = int(cd['ida'])
        fields = ['nombres', 'nombre', 'region', 'provincia', 'distrito', 'telefono', 'referencia', 'region', 'provincia', 'distrito']
        dd = {}
        if ida == 0:
            for f in fields:
                dd[f] = cd[f]
            row = Direccion(**dd)
            if request.user:
                row.usuario = Usuario.objects.get(pk=request.user.pk)
            row.save()
        else:
            row = Direccion.objects.get(pk=ida)
            for f in fields:
                row.__dict__[f] = cd[f]
            row.save()
        return row


class RegionesForm(forms.Form):
    # nombre = forms.CharField()

    def result(self):
        cd = self.cleaned_data
        res = Region.objects.filter(active=True).order_by('nombre')
        result = list()
        for i in res:
            x = {
                'id': i.id,
                'nombre': i.nombre,
                'codigo': i.codigo,
            }
            result.append(x)
        return result


class ProvinciasForm(forms.Form):
    region = forms.CharField()

    def result(self):
        cd = self.cleaned_data
        res = Provincia.objects.filter(region=int(cd['region']), active=True).order_by('nombre')
        result = list()
        for i in res:
            x = {
                'id': i.id,
                'nombre': i.nombre,
                'codigo': i.codigo,
            }
            result.append(x)
        return result


class DistritosForm(forms.Form):
    provincia = forms.CharField()

    def result(self):
        cd = self.cleaned_data
        res = Distrito.objects.filter(provincia=int(cd['provincia']), active=True).order_by('nombre')
        result = list()
        for i in res:
            x = {
                'id': i.id,
                'nombre': i.nombre,
                'codigo': i.codigo,
            }
            result.append(x)
        return result
