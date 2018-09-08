import json
from os.path import join

import os

from django.core.exceptions import ImproperlyConfigured


def get_environ(var_name, default=None):
    '''
        Retorna una variable de entorno o un valor por defecto o muestra un
        mensaje indicando el error.
    '''
    try:
        return os.environ[var_name]
    except KeyError:
        if default:
            return default
        else:
            error_msg = 'Asigne un valor a la variable de entorno: \"{0}\"'.format(
                var_name)
            raise ImproperlyConfigured(error_msg)

def get_env(base_dir):
    """ Obtenemos las 'variables de entorno' desde un archivo json."""
    with open(join(base_dir, 'settings/settings.json')) as f:
        env = json.load(f)
        return env
    return {}
