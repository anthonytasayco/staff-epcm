from django.apps import AppConfig
from django.contrib.admin.checks import check_admin_app
from django.core import checks


class SimpleAdminConfig(AppConfig):
    """Simple AppConfig which does not do automatic discovery."""

    name = 'apps.formularios'
    verbose_name = "Formularios de la web"

    def ready(self):
        checks.register(check_admin_app, checks.Tags.admin)


class AdminConfig(SimpleAdminConfig):
    """The default AppConfig for admin which does autodiscovery."""

    def ready(self):
        super(AdminConfig, self).ready()
        # self.module.autodiscover()