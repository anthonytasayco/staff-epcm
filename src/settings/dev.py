# -*- coding: utf-8 -*-
'''
    settings for development
'''

# settings/base.py

from base import *

INSTALLED_APPS += (
    'debug_toolbar',
    'django_extensions',
    'django_nose',
)

TEST_RUNNER = 'django_nose.NoseTestSuiteRunner'

NOSE_ARGS = []
