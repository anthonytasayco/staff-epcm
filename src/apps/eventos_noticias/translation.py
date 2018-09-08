from modeltranslation.translator import translator, TranslationOptions

from .models import (HomeEventosSeccion,EventosSociales,HomeNoticiasSeccion,Noticias)

class HomeEventosSeccionTranslationOptions(TranslationOptions):
	fields = ('cabecera','b_titulo','b_descript')

class EventosSocialesTranslationOptions(TranslationOptions):
	fields = ('nombre','descript')

class HomeNoticiasSeccionTranslationOptions(TranslationOptions):
	fields = ('cabecera','b_titulo','b_descript')

class NoticiasTranslationOptions(TranslationOptions):
	fields = ('nombre','nombre_x','descript')

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

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')

# class TranslationOptions(TranslationOptions):
# 	fields = ('nombre','','','','','','','','','','','','','','','','','','','','','','','','','','')


### Primera version
translator.register(HomeEventosSeccion, HomeEventosSeccionTranslationOptions)
translator.register(EventosSociales, EventosSocialesTranslationOptions)
translator.register(HomeNoticiasSeccion, HomeNoticiasSeccionTranslationOptions)
translator.register(Noticias, NoticiasTranslationOptions)