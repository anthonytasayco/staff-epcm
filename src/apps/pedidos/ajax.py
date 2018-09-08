# -*- coding: utf-8 -*-
from datetime import datetime
from logging import getLogger
from ratelimit.decorators import ratelimit

from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import logout_then_login
from django.core.urlresolvers import reverse, reverse_lazy
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response as render, redirect
from django.template import RequestContext as ctx

# from .forms import (EditUsuarioForm, LoginForm, RegistroForm, RecuperaPasswordForm, DireccionForm,
#     SetPasswordForm)
# from .models import Region, Provincia, Distrito
from django.forms.models import model_to_dict
from apps.web.utils import get_info
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json

log = getLogger('django')
