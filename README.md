# Instalación de projecto

Ejecutar los siguientes comandos en la terminal.

```
~$ mkvirtualenv django_1_7_jet
~$ pip install -r rq-1.7-jet.txt
~$ cp src/settings/settings.json.template src/settings/settings.json
~$ nano src/settings/settings.json
   # Editar las variables
~$ fab install_app:dashboard_init.json
```

* Totas la variables importantes se declaran en el settings.json

Para edición de la maqueta (css y html) ejecutar este comando:

```
~$ gulp #(inicia los compliadores pero no inicia el servidor.)
   # o este otro
~$ gulp server #(inicia los compliadores y el servidor.)

```

En caso de no tener la dependencias:

```
~$ sudo npm install -g
~$ gulp server
```