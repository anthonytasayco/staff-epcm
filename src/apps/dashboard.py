# -*- coding: utf-8 -*-

from django.conf import settings
from django.utils.translation import ugettext_lazy as _

from grappelli.dashboard import modules, Dashboard
from grappelli.dashboard.utils import get_admin_site_name

ADMIN_URL = settings.ADMIN_URL



class CustomIndexDashboard(Dashboard):
	'''
		Custom index dashboard for web
	'''

	def __init__(self, **kwargs):
		Dashboard.__init__(self, **kwargs)

		self.children.append(modules.ModelList(
			'Clientes',
			collapsible=False,
			column=1,
			models=['apps.custom_auth.models.' + model for model in (
					'Usuario',
					)]
		))
		self.children.append(modules.ModelList(
			_('Pedidos Paypal'),
			column=1,
			collapsible=False,
			models=(
				# 'django.contrib.*',
				'paypal.standard.pdt.models.*',
			),
		))
		self.children.append(modules.ModelList(
			_('Pedidos PagoEfectivo'),
			column=1,
			collapsible=False,
			models=['apps.pedidos.models.' + model for model in (
					'PagoEfectivoData',
			)]
		))
		self.children.append(modules.ModelList(
			'Pedidos',
			collapsible=False,
			column=1,
			models=['apps.pedidos.models.' + model for model in (
					'Pedido',
					'CodigosDeDescuento',
					'PaypalInfo'

					)]
		 ))
		self.children.append(modules.ModelList(
			'Formularios',
			collapsible=False,
			column=1,
			models=['apps.formularios.models.' + model for model in (
					'Contacto',
					'Suscript',
					'ContactoInformacion',
					'LibRec',
					'Destinatarios'
					)]
		))

		self.children.append(modules.ModelList(
			'Home : Pantalla Principal',
			collapsible=False,
			column=1,
			models=['apps.web.models.' + model for model in (
					'InfoSite',
					'Sliders',
					'SeccionInferior',
					'PorqueElegirnos',
					'ContactoSeccion',
					'LibroSeccion',
					)]
		))

		self.children.append(modules.ModelList(
			'Nosotros',
			collapsible=False,
			column=1,
			models=['apps.web.models.' + model for model in (
					'Conocenos',
					'Clientes',
					'EllosOpinan',
					'Respaldos',
					'Paises'
					)]
		))

		self.children.append(modules.ModelList(
			'Cursos',
			collapsible=False,
			column=1,
			models=['apps.cursos.models.' + model for model in (
					'CursosCategorias',
					'CursosDeInteres',
					'Rubros',
					'Idiomas',
					'Cursos',
					'Profesores'
					)]
		))

		self.children.append(modules.ModelList(
			'Eventos y Noticias',
			collapsible=False,
			column=1,
			models=['apps.eventos_noticias.models.' + model for model in (
					'HomeEventosSeccion',
					'EventosSociales',
					'HomeNoticiasSeccion',
					'Noticias'
					)]
		))
		
		self.children.append(modules.ModelList(
			'Terminos y Preguntas frecuentes',
			collapsible=False,
			column=1,
			models=['apps.terminos_preguntas.models.' + model for model in (
					'TermsSeccion',
					'Terms',
					'QuestSeccion',
					'Quest'
					)]
		))

		self.children.append(modules.LinkList(
			u'Información del Sitio',
			collapsible=False,
			column=2,
			children=[
				{
					'title': 'Configuración',
					'url': '/{0}/web/infosite/1'.format(ADMIN_URL),
					'external': False,
				},
				{
					'title': 'Diccionario de Textos Estáticos',
					'url': '/{0}/web/translaterdicc/'.format(ADMIN_URL),
					'external': False,
				}
			]
		))

		self.children.append(modules.LinkList(
			u'Herramientas SEO',
			collapsible=False,
			column=2,
			children=[
				{
					'title': u'Información URL (MetaTags)',
					'url': '/{0}/seo/seotags/'.format(ADMIN_URL),
					'external': False,
				},
				{
					'title': u'Re-Direccionamientos',
					'url': '/{0}/seo/seoredirects/'.format(ADMIN_URL),
					'external': False,
				},
				{
					'title': u'URL registradas',
					'url': '/{0}/seo/urlregister/'.format(ADMIN_URL),
					'external': False,
				}
			]
		))

		self.children.append(modules.LinkList(
			_('Soporte'),
			collapsible=False,
			column=2,
			children=[
				{
					'title': 'StaffDigital',
					'url': 'http://www.staffdigital.pe/',
					'external': False,
				},
				{
					'title': _('desarrollo@staffdigital.pe'),
					'url': 'mailto:desarrollo@staffdigital.pe',
					'external': True,
					'description': u'Escríbenos',
				},
			]
		))

		self.children.append(modules.RecentActions(
			_('Acciones Recientes'),
			limit=10,
			collapsible=False,
			column=2,
		))
