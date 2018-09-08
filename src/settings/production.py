# -*- coding: utf-8 -*-
# production.py

from .base import *

DEBUG = ENV.get('DEBUG_PRODUCTION', False)

PREPEND_WWW = ENV.get('PREPEND_WWW', False)


# DIRS
MEDIA_ROOT = ENV.get('MEDIA_ROOT', '')
MEDIA_URL = ENV.get('MEDIA_URL', '')
STATIC_ROOT = ENV.get('STATIC_ROOT', '')
STATIC_URL = ENV.get('STATIC_URL', '')

##Hostname
ALLOWED_HOSTS = ENV.get('ALLOWED_HOSTS', '')

# SESSIONS

SESSION_EXPIRE_AT_BROWSER_CLOSE = ENV.get('SESSION_EXPIRE', True)

GEOPOSITION_MARKER_OPTIONS = {
    'cursor': 'move',
    'icon': STATIC_URL+'marker/marker.png'
}

# CACHE
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.db.DatabaseCache',
        'LOCATION': 'cache_table',
        'TIMEOUT': '300',
    }
}

if ENV.get('SENTRY_DSN', ''):
    import os
    import raven
    INSTALLED_APPS += ('raven.contrib.django.raven_compat',)
    RAVEN_CONFIG = {
        'dsn': ENV.get('SENTRY_DSN', ''),
        'release': ENV.get('SENTRY_RELEASE', 'undefined')
    }
from ckConfig import *
CKEDITOR_JQUERY_URL = '{0}js/jquery.min-ckeditor.bk.js'.format(STATIC_URL,)