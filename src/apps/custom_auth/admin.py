# -*- coding: utf-8 -*-

from django.contrib import admin

from .models import Usuario, Distrito, Region, Provincia, Direccion
# from apps.catalogo.models import Favoritos

class DireccionInline(admin.StackedInline):
    model = Direccion
    # readonly_fields = ['usuario']
    extra = 0

    def get_readonly_fields(self, request, obj=None):
        result = list(set(
                [field.name for field in self.opts.local_fields] +
                [field.name for field in self.opts.local_many_to_many]
            ))
        result.remove('id')
        return result

# class FavoritosInline(admin.TabularInline):
#     model = Favoritos
#     readonly_fields = ['producto']
#     extra = 0

# @admin.register(Usuario)
class UsuarioAdmin(admin.ModelAdmin):
    # list_display = ('email',)
    list_display = ('email', 'nombres', 'apellidos', 'telefono', 'is_active',)
    inlines = [DireccionInline]


class RegionAdmin(admin.ModelAdmin):
    model = Region
    search_fields = ['nombre', 'codigo']
    list_display = [ 'nombre', 'active',  'delivery']

class ProvinciaAdmin(admin.ModelAdmin):
    model = Provincia
    search_fields = ['nombre', 'codigo']
    list_display = [ 'nombre', 'active',  'delivery', 'region']


class DistritoAdmin(admin.ModelAdmin):
    model = Distrito
    search_fields = ['nombre', 'codigo']
    list_display = [ 'nombre','active', 'codigo', 'delivery', 'provincia']
    # list_display = ['nombre', 'codigo', 'delivery']
# /    inlines = [ServiciosElementoInline]


admin.site.register(Usuario, UsuarioAdmin)

admin.site.register(Region, RegionAdmin)
admin.site.register(Provincia, ProvinciaAdmin)
admin.site.register(Distrito, DistritoAdmin)
