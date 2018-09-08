import os
import sys

from os.path import dirname, realpath
from site import addsitedir
import json
from os.path import dirname, realpath, join

BASE_DIR = dirname(realpath(__file__))

def get_env(base_dir):
	""" Obtenemos las 'variables de entorno' desde un archivo json."""
	with open(join(base_dir, 'settings/settings.json')) as f:
		env = json.load(f)
		return env
	return {}

ENV = get_env(BASE_DIR)
WORKON_HOME = ENV.get('WORKON_HOME', '')
SETTINGS_PROD = ENV.get('SETTINGS_PROD')
if not WORKON_HOME:
	WORKON_HOME = os.environ['WORKON_HOME']
VENV = ENV.get('ENV', 'django_1_7')

addsitedir('{0}/{1}/lib/python2.7/site-packages'.format(WORKON_HOME, VENV))

sys.path = [BASE_DIR] + sys.path

os.environ.setdefault('DJANGO_SETTINGS_MODULE', SETTINGS_PROD)

# activamos el entorno virtual
if not sys.platform == 'win32':
	activate_this = os.path.expanduser(
		'{0}/{1}/bin/activate_this.py'.format(WORKON_HOME, VENV))
	execfile(activate_this, dict(__file__=activate_this))

from django.core.wsgi import get_wsgi_application

application = get_wsgi_application()