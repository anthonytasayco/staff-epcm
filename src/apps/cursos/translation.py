from modeltranslation.translator import translator, TranslationOptions

from .models import (
    CursosDeInteres,
    CursosCategorias,
    Idiomas,
    Rubros,
    Cursos,
    Contenidos,
    Beneficios,
    Profesores
)


class CursosDeInteresTranslationOptions(TranslationOptions):
    # pass
    fields = ('titulo', 'detalle')


class CursosCategoriasTranslationOptions(TranslationOptions):
    # pass
    fields = ('nombre', 'descript')


class IdiomasTranslationOptions(TranslationOptions):
    # pass
    fields = ('nombre',)


class RubrosTranslationOptions(TranslationOptions):
    # pass
    fields = ('nombre',)


class CursosTranslationOptions(TranslationOptions):
    # pass
    fields = ('nombre', 'nombre_complex', 'descript', 'archivo', 'fechas',
              'horarios', 'lugar', 'inversion', 'mt_titulo', 'mt_descript', 'dc_titulo',
              'dc_descript', 'iv_descript', 'iv_tabla', 'iv_descript_pie', 'dm_titulo',
              'dm_descript')


class ContenidosTranslationOptions(TranslationOptions):
    # pass
    fields = ('nombre', 'descript')


class BeneficiosTranslationOptions(TranslationOptions):
    # pass
    fields = ('nombre', 'descript')


class ProfesoresTranslationOptions(TranslationOptions):
    # pass
    fields = ('detalle', 'cargo', 'descript', 'descript_simple')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')


# Primera version
translator.register(CursosDeInteres, CursosDeInteresTranslationOptions)
translator.register(CursosCategorias, CursosCategoriasTranslationOptions)
translator.register(Idiomas, IdiomasTranslationOptions)
translator.register(Rubros, RubrosTranslationOptions)
translator.register(Cursos, CursosTranslationOptions)
translator.register(Contenidos, ContenidosTranslationOptions)
translator.register(Beneficios, BeneficiosTranslationOptions)
translator.register(Profesores, ProfesoresTranslationOptions)
