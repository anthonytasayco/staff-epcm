from modeltranslation.translator import translator, TranslationOptions

from .models import (TermsSeccion,Terms,QuestSeccion,Quest)

class TermsSeccionTranslationOptions(TranslationOptions):
	fields = ('cabecera','b_titulo')

class TermsTranslationOptions(TranslationOptions):
	fields = ('nombre','descript')

class QuestSeccionTranslationOptions(TranslationOptions):
	fields = ('cabecera','b_titulo')

class QuestTranslationOptions(TranslationOptions):
	fields = ('nombre','descript')

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
translator.register(TermsSeccion, TermsSeccionTranslationOptions)
translator.register(Terms, TermsTranslationOptions)
translator.register(QuestSeccion, QuestSeccionTranslationOptions)
translator.register(Quest, QuestTranslationOptions)