#!/usr/bin/env python
# -*- coding: utf-8 -*-

from functools import wraps
from site import addsitedir
from os.path import abspath, dirname, join
import json
import sys
import os
import socket

from fabric.api import local, task, env
from fabric.colors import blue, green, red
from fabric.context_managers import prefix
from fabric.contrib import django

from fab_extras import cron

# Añadimos la raiz del proyecto al path
BASE_DIR = abspath(join(dirname(__file__), 'src'))
sys.path.append(BASE_DIR)
with open(join(BASE_DIR, 'settings/settings.json')) as f:
    ENV = json.load(f)

# Añadimos virtualenv al path
try:
    WORKON_HOME = ENV['WORKON_HOME']
    DJANGO_ENV = ENV['ENV']
except:
    WORKON_HOME = os.environ['WORKON_HOME']
    DJANGO_ENV = 'django_1_7'
addsitedir('{0}/{1}/lib/python2.7/site-packages'.format(WORKON_HOME, DJANGO_ENV))
try:
    m_user = ENV['MERCURIAL_USER']
except:
    m_user = False

django.settings_module('settings')

env.shell = '/bin/bash'

# from django.conf import settings

apps_list = 'web seo formularios eventos_noticias terminos_preguntas cursos pedidos custom_auth'
lang_list = ['es','en','pt']



if os.name != "nt":
    import fcntl
    import struct
    def get_interface_ip(ifname):
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        return socket.inet_ntoa(fcntl.ioctl(
                s.fileno(),
                0x8915,
                struct.pack('256s', ifname[:15])
            )[20:24])

def get_lan_ip():
    ip = socket.gethostbyname(socket.gethostname())
    if ip.startswith("127.") and os.name != "nt":
        interfaces = ["eth0","eth1","enp0s3","eth2","wlan0","wlan1","wifi0","ath0","ath1","ppp0"]
        for ifname in interfaces:
            try:
                ip = get_interface_ip(ifname)
                break;
            except IOError:
                pass
    return ip



ipdata = get_lan_ip()

# VIRTUALENV
def virtualenv():
    '''
        Context manager. Usado para ejecutar acciones con virtualenv activado::

        with virtualenv():
            # virtualenv está activo aquí
    '''

    return prefix('export ENV="{0}";. {1}/{0}/bin/activate'.format(DJANGO_ENV, WORKON_HOME))


def inside_virtualenv(func):
    '''
        Decorador, usado para ejecutar acciones con virtualenv activado::

        @task
        @inside_virtualenv
        def my_command():
            # virtualenv está activo aquí
    '''
    @wraps(func)
    def inner(*args, **kwargs):
        with virtualenv():
            return func(*args, **kwargs)
    return inner


# TAREAS
@task
@inside_virtualenv
def cache():
    '''
        Crea la tabla para la cache
    '''
    print(blue('::cache::'))
    local('./src/manage.py createcachetable cache_table')
    print(green('::::cache()::::'))



@task
@inside_virtualenv
def lang():
    '''
        Crea la tabla para la cache
    '''
    for lng in lang_list:
        print(blue('::Creating files for {0}...::'.format(lng,)))
        local('./src/manage.py makemessages -l {0}'.format(lng,))
        print(blue('::Processing files for {0}...::'.format(lng,)))
        local('./src/manage.py compilemessages -l {0}'.format(lng,))
    print(green('::::complete ()::::'))

@task
def memcached():
    '''
        Copia el script que reinicia memcached y lo añade como un cronjob.
    '''
    print(blue('::memcached()::'))
    local('mkdir -p ~/scripts')
    local('cp extra/memcached_usage.sh ~/scripts/memcached_usage.sh')
    cron_line = '*/5 * * * * cd ~/scripts;./memcached_usage.sh > /dev/null 2>&1'
    cron.update_line(cron_line, 'memcached')
    print(green('::::memcached()::::'))


@task
@inside_virtualenv
def sqldiff():
    '''
        Muestra incongruencias con la base de datos
    '''
    print(blue('::sqldiff::'))
    local('./src/manage.py sqldiff {0}'.format(apps_list,))
    print(green('::::sqldiff()::::'))

@task
@inside_virtualenv
def dumpdata():
    '''
        Muestra incongruencias con la base de datos
    '''
    print(blue('::sqldiff::'))
    local('./src/manage.py dumpdata {0} > all_db.json'.format(apps_list,))
    print(green('::::sqldiff()::::'))


@task
@inside_virtualenv
def migrate():
    '''
        Ejecuta las migraciones
    '''
    print(blue('::migrate::'))
    local('./src/manage.py migrate --settings=settings.production')
    print(green('::::migrate()::::'))


@task
def commit(descript='Fix Update',user='Ccapu-StaffDigital'):
    '''
        Ejecuta las migraciones
    '''
    print(blue('::Agregando Archivos::'))
    local("hg addremove")
    print(blue('::Obteniendo cambios de la Red::'))
    local("hg pull -u")
    print(blue('::Realizando el commit::'))
    if user == "gc" or user == "ccapu":
        local(u"hg commit -m '{1}'".format(descript.decode('utf-8'),))
        local("hg commit -m '"+descript+"'")
    elif m_user:
        local(u"hg commit -u '{0}' -m '{1}'".format(m_user.decode('utf-8'),descript.decode('utf-8')))
    else:
        local(u"hg commit -u '{0}' -m '{1}'".format(user.decode('utf-8'),descript.decode('utf-8')))
    print(blue('::Subiendo cambios::'))
    local("hg push")
    print(green(':::: Cambios subidos con exito ::::'))

@task
@inside_virtualenv
def addApache(domain="",httpd_conf="../apache2/conf/httpd.conf"):
    '''
        Ejecuta la Instalación del Proyecto (Modo Genérico)
    '''
    if domain == "":
        domain = confirmacion = raw_input("Ingrese dominio de la web\n")
    script = '''##### InitConfig #####
<VirtualHost *:{0}>
    ServerName {1}
    ServerAlias {1}
    KeepAlive On
    KeepAliveTimeout 2
    WSGIDaemonProcess {2} processes=1 threads=2 inactivity-timeout=20 display-name=[wsgi-{2}]httpd
    WSGIProcessGroup {2}
    WSGIScriptAlias / {3}/src/wsgi.py
</VirtualHost>
    '''
    try:
        msg = "(NOhayMigaja :v)"
        migaja = False
        path = os.getcwd().split('/')[-1:]
        httpd2 = open(httpd_conf.strip(),'r')
        httpd = open(httpd_conf.strip(),'r')
        bkfile = httpd2.read()
        httpd_lines = httpd.readlines()
        for line in httpd_lines:
            if "NameVirtualHost *:" in line:
                port = line.replace('NameVirtualHost *:','')
            if "##### InitConfig #####" in line:
                migaja = True
                msg = " (Se encontro la migaja)"
        print(blue(':: Creando script para agregar ::'))
        script = script.format(port.strip(),domain.strip(),path[0].replace('_','-'),os.getcwd())
        print script
        confirmacion = raw_input(msg+"\nEl script es correcto? y/n\n")
        if confirmacion == "si" or confirmacion == "y":
            if migaja:
                with open(httpd_conf.strip(), "w") as myfile:
                    myfile.write(bkfile.replace("##### InitConfig #####",script))
                with open("../httpd.orig", "w") as myfile:
                    myfile.write(bkfile)
                with open(httpd_conf.strip()+".history", "a") as myfile:
                    myfile.write(bkfile)
            else:
                with open(httpd_conf.strip(), "a") as myfile:
                    myfile.write(script)

            print(green('Se ha realizado el proceso correctamente. Gracias!'))
        else:
            print(red("Se ha cancelado el proceso. Gracias!"))
        httpd.close()
        httpd2.close()
    except Exception, e:
        print e
        print(red("Error de agregado por favor agregarlo de manera manual"))


@task
@inside_virtualenv
def sync_apps():
    print(blue(':: MakeMigrations ::'))
    local('./src/manage.py makemigrations {0}'.format(apps_list,))
    print(green(':::: MakeMigration_successfully() ::::'))
    print(blue(':: Migrating... ::'))
    local('./src/manage.py migrate')
    print(green(':::: Migrate_Complete() ::::'))


@task
@inside_virtualenv
def install_app(db=None):
    '''
        Ejecuta la Instalación del Proyecto (Modo Genérico)
    '''
    print(blue(':: Creating cache_table ::'))
    local('./src/manage.py createcachetable cache_table')
    print(green(':::: cache_table_created_successfully() ::::'))
    print(blue(':: MakeMigrations ::'))
    local('./src/manage.py makemigrations {0}'.format(apps_list,))
    print(green(':::: MakeMigration_successfully() ::::'))
    print(blue(':: Migrating... ::'))
    local('./src/manage.py migrate')
    print(green(':::: Migrate_Complete() ::::'))
    print(blue(':: Creating SuperUser ::'))
    local('./src/manage.py createsuperuser')
    print(green(':::: SuperUser_created_successfully() ::::'))
    if db:
        print(blue(':: Loading Data from '+db+' ::'))
        local('./src/manage.py loaddata '+db)
        print(green(':::: Load_Complete() ::::'))

@task
@inside_virtualenv
def run(port=None):
    '''
        Ejecuta el lanze del servidor
    '''
    print(green('::RunServer - Ccapu-ip-address::'))
    if port:
        local('./src/manage.py runserver 0:'+port)
    else:
        local('./src/manage.py runserver 0:8000')
    reversion()
    print(green('::::RunServer - Ccapu-ip-address()::::'))


@task
def pep8():
    '''
        Crea la revisiones iniciales de los modelos.
    '''
    print(blue('::pep8()::'))
    local('pep8 --config setup.cfg .')
    print(green('::::pep8()::::'))


@task
@inside_virtualenv
def static():
    '''
        Ejecuta el comando collectstatic
    '''
    print(blue('::static()::'))

    local('./src/manage.py collectstatic --noinput --settings=settings.production')

    print(green('::::static()::::'))


@task
def stylus():
    '''
        Compila código stylus.
    '''
    print(blue('::stylus()::'))

    local('stylus -w src/static/styl/ -o src/static/css/')

    print(green('::::stylus()::::'))


@task
@inside_virtualenv
def test(extra=''):
    '''
        Ejecuta los test's
    '''
    print(blue('::test()::'))

    if extra == 'dev':
        local('./src/manage.py test --settings=settings.dev')
        pep8()
    else:
        local('./src/manage.py test')
    print(green('::::test()::::'))
