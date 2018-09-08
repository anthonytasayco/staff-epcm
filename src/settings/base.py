# -*- coding: utf-8 -*-
"""
Django settings for web project.
"""

# import sys
from os.path import dirname, join, realpath, expanduser
import os
from apps.core.util.network import get_lan_ip
from util import get_env

BASE_DIR = dirname(dirname(realpath(__file__)))
UserPath = expanduser("~")
ENV = get_env(BASE_DIR)

DEBUG = ENV.get('DEBUG', True)
TEMPLATE_DEBUG = DEBUG
ALLOWED_HOSTS = ENV.get('ALLOWED_HOSTS', [])
SECRET_KEY = ENV.get('SECRET_KEY','')
# PROJECT_NAME = u'Django SingleLang'
AUTH_SECRET_KEY = ENV.get('AUTH_SECRET_KEY', 'my_super_secret_key')
EMAIL_DEVELOPER = []

PROJECT_NAME = ENV.get('PROJECT_NAME','Django SingleLang')

PAGOEFECTIVO_URL = ENV.get('PAGOEFECTIVO_URL', 'https://pre1a.pagoefectivo.pe/')

SEO_SUPPORT = ['seo@staffdigital.pe','desarrollo@staffdigital.pe','chevarrias@gmail.com']

ADMINS = (
    ('StaffDigital', 'desarrollo@staffdigital.pe'),
)

MANAGERS = ADMINS

SITE_ID = 1

# EMAIL
EMAIL_HOST = ENV.get('EMAIL_HOST', '')
EMAIL_HOST_USER = ENV.get('EMAIL_HOST_USER', '')
EMAIL_HOST_PASSWORD = str(ENV.get('EMAIL_HOST_PASSWORD', ''))
DEFAULT_FROM_EMAIL = ENV.get('DEFAULT_FROM_EMAIL', '')
SERVER_EMAIL = ENV.get('SERVER_EMAIL', '')
EMAIL_PORT = int(ENV.get('EMAIL_PORT', ''))
EMAIL_BACKEND = ENV.get('EMAIL_BACKEND', '')
if bool(ENV.get('EMAIL_USE_TLS', True)):
    EMAIL_USE_TLS = True
else:
    EMAIL_USE_SSL = True


# DB
DATABASES = {
    'default': {
        'ENGINE': ENV.get('DB_API','django.db.backends.postgresql_psycopg2'),
        'NAME': ENV.get('DB_NAME', ''),
        'USER': ENV.get('DB_USER'),
        'PASSWORD': ENV.get('DB_PASSWORD'),
        'HOST': ENV.get('DB_HOST','localhost'),
        'PORT': ENV.get('DB_PORT','')
    }
}

ipdata = get_lan_ip()
ALLOWED_HOSTS.append(ipdata)

# Localizacion e internacionalizacion
TIME_ZONE = 'America/Lima'
LANGUAGE_CODE = 'es'

USE_I18N = True
USE_L10N = True
USE_TZ = False

gettext = lambda s: s
LANGUAGES = (
        ('es', gettext('Spanish')),
        ('en', gettext('English')),
        ('pt', gettext('Portugues')),
    )
MODELTRANSLATION_DEFAULT_LANGUAGE = 'es'
MODELTRANSLATION_TRANSLATION_FILES = (
    'apps.web.translation',
    'apps.eventos_noticias.translation',
    'apps.terminos_preguntas.translation',
)

LOCALE_PATHS = (
    join(BASE_DIR, 'locale'),
)

# ADMIN, MEDIA y STATIC
ADMIN_URL = ENV.get('ADMIN_URL', 'admin-staff')

if DEBUG==False :
    ubic = os.getcwd()

    MEDIA_ROOT = ubic+'/src/media/'
    MEDIA_URL = '/media/'

    STATIC_ROOT = ubic+'/src/static/'
    STATIC_URL = '/static/'

else:

    MEDIA_ROOT = join(BASE_DIR, 'media')
    MEDIA_URL = '/media/'

    STATIC_ROOT = ''
    STATIC_URL = '/static/'

STATICFILES_DIRS = (
    join(BASE_DIR, 'static'),
)

STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
)

# Para normalizar nombres de archivo en formato ASCII en vez de Unicode
DEFAULT_FILE_STORAGE = 'apps.core.util.storage.ASCIIFileSystemStorage'


# templates
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
)

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'django.core.context_processors.media',
    'django.core.context_processors.static',
    'django.contrib.messages.context_processors.messages',
    # 'django.middleware.locale.LocaleMiddleware',
    'django.core.context_processors.request',
    'apps.web.util.setInfoSite'
)

TEMPLATE_DIRS = (
    join(BASE_DIR, 'templates'),
)
AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
    'apps.custom_auth.backend.AuthBackend',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'apps.seo.middleware.RedirectFallbackMiddleware',
    'apps.core.util.crossdomainxhr.XsSharing'
)

ROOT_URLCONF = 'urls'

WSGI_APPLICATION = 'wsgi.application'


INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.sitemaps',
    'django.contrib.sites',
    'django.contrib.staticfiles',
    ## admin
    'modeltranslation',
    'grappelli.dashboard',
    'grappelli',
    'filebrowser',
    'smart_selects',
    'ckeditor',
    'django.contrib.admin',
    ## external apps
    'admin_honeypot',
    "geoposition",
    'watchman',
    ## local apps
    'paypal.standard.pdt',
    'django_extensions',
    'apps.core',
    'apps.web',
    'apps.eventos_noticias',
    'apps.terminos_preguntas',
    'apps.pedidos',
    'apps.custom_auth',
    'apps.cursos',
    'apps.formularios',
    'apps.seo',
)

### Jet
FILEBROWSER_SHOW_IN_DASHBOARD = False

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'formatters': {
        'simple': {
            'format': '%(levelname)s %(message)s'
        }
    },
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'apps.core.util.log.ColorizingStreamHandler',
            'formatter': 'simple'
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'propagate': True,
            'level': 'INFO',
        }
    }
}


# CACHE
CACHES = {
    'file': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'super_cache_mem.mem'
    },
    'default': {
        'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
        'LOCATION': BASE_DIR+'/'+'super_cache_mem.sock'
    },
    'dtb': {
        'BACKEND': 'django.core.cache.backends.db.DatabaseCache',
        'LOCATION': 'cache_table',
        'TIMEOUT': '900',
    }
}


## Grappelli settings
GRAPPELLI_ADMIN_TITLE = PROJECT_NAME.title()+' | Administrador de contenidos'
GRAPPELLI_INDEX_DASHBOARD = 'apps.dashboard.CustomIndexDashboard'




## FileBrowser settings
FILEBROWSER_MAX_UPLOAD_SIZE = 26214400  # 25 MB
FILEBROWSER_NORMALIZE_FILENAME = True
FILEBROWSER_OVERWRITE_EXISTING = False
FILEBROWSER_LIST_PER_PAGE = 69

FILEBROWSER_SHOW_PLACEHOLDER = True
FILEBROWSER_PLACEHOLDER = 'no-disponible/no-disponible.png'
FILEBROWSER_EXTENSIONS = {
    'Folder': [''],
    'compress': ['.rar', '.tar', '.zip'],
    'Image': ['.jpg', '.jpeg', '.gif', '.png', '.tif', '.tiff'],
    'Document': ['.pdf', '.doc', '.rtf', '.txt', '.xls', '.csv', '.swf'],
    'Video': ['.mov', '.wmv', '.mpeg', '.mpg', '.avi'],
    'Audio': ['.mp3', '.mp4', '.wav', '.aiff', '.midi', '.m4p']
}

FILEBROWSER_SELECT_FORMATS = {
    'file': ['Folder', 'Image', 'Document', 'Video', 'Audio'],
    'image': ['Image'],
    'document': ['Document'],
    'media': ['Video', 'Audio'],
}

# admin-honeypot
ADMIN_HONEYPOT_EMAIL_ADMINS = False


TEST_RUNNER = 'django.test.runner.DiscoverRunner'

#GeoPosition settings
GEOPOSITION_GOOGLE_MAPS_API_KEY=ENV.get('GEOPOSITION_GOOGLE_MAPS_API_KEY', '')
GEOPOSITION_MAP_OPTIONS = {
    'minZoom': 3,
    'maxZoom': 18,
}

from ckConfig import *
CKEDITOR_JQUERY_URL = '{0}js/jquery.min-ckeditor.bk.js'.format(STATIC_URL,)

# SILENCED_SYSTEM_CHECKS = ["1_10.W001"]
PAYPAL_IDENTITY_TOKEN=ENV.get('PAYPAL_IDENTITY_TOKEN', '')
PAYPAL_TEST=ENV.get('PAYPAL_TEST', False)
