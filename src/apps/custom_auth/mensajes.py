# -*- coding: utf-8 -*-

def mensajes_auth(request, cod = ''):
    if cod == 'login.recuera_password.envio':
        tipo = 'ok'
        titulo = u'Recuperar Contraseña'
        texto = u''
        contenido = u'Se ha enviado un email con los pasos a seguir'

    if cod == 'login.set_password.envio':
        tipo = 'ok'
        titulo = u'Actualización de Contraseña'
        texto = u''
        contenido = u'Se ha actualizado satisfatoriamente, ahora puede iniciar sesión con la nueva contraseña'

    if cod == 'login.cuenta.update':
        tipo = 'ok'
        titulo = u'Mis datos'
        texto = u''
        contenido = u'Se actualizó satisfactoriamente'

    if cod == 'login.acceso.error':
        tipo = 'error'
        titulo = u'Login'
        texto = u''
        contenido = u'¡Accesos Incorrectos!'

    if cod == 'cuenta.deseos.add':
        tipo = 'ok'
        titulo = u'Lista de deseos'
        texto = u''
        contenido = u'Se ha agregado el producto a las lista de Deseos'

    if cod == 'login.registro.ok':
        tipo = 'ok'
        titulo = u'Registro'
        texto = u'Bienvenido'
        contenido = u'Se ha registrado e iniciado sesión satisfactoriamente'




    if cod != '':
        request.session['msgs_tipo'] = tipo
        request.session['msgs_titulo'] = titulo
        request.session['msgs_texto'] = texto
        request.session['msgs_contenido'] = contenido
