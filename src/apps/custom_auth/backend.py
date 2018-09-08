# -*- coding: utf-8 -*-

from datetime import datetime
from logging import getLogger

from .models import Usuario

log = getLogger('django')


class AuthBackend(object):

    def authenticate(self, username=None, password=None):
        user = None
        users = Usuario.objects.filter(email=username)
        if users.exists():
            user = users[0]
        else:
            return None

        if user.is_password_valid(password):
            user.last_login = datetime.now()
            user.save()
            return user

        log.debug(u'La contraseña es incorrecta')
        return None

    def get_user(self, username):
        log.debug('get_user: {0}'.format(username))
        try:
            return Usuario.objects.get(id=username)
        except Usuario.DoesNotExist:
            log.debug('El usuario no existe')
            return None
