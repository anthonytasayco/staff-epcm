from modeltranslation.translator import translator, TranslationOptions

from .models import (InfoSite, Sliders, PorqueElegirnos, Conocenos, EllosOpinan,
                     Paises, ContactoSeccion, LibroSeccion, TranslaterDicc)

from ..pedidos.models import PaypalInfo


class InfoSiteTranslationOptions(TranslationOptions):
    fields = ('campus',)


class TranslaterDiccTranslationOptions(TranslationOptions):
    fields = ('nombre',)


class SlidersTranslationOptions(TranslationOptions):
    fields = ('titulo', 'enlace_text')


class PorqueElegirnosTranslationOptions(TranslationOptions):
    fields = ('nombre', 'descript')


class ConocenosTranslationOptions(TranslationOptions):
    fields = ('cabecera', 'qs', 'pa', 'ms', 'vs', 'bg_titulo',
        'cf_vid', 'cf_vid_id', 'cf_descript', 'ns_titulo',
        'ns_descript', 'nr_titulo', 'nr_descript','cf_vimeo',
        'cf_vimeo_id'
    )


class EllosOpinanTranslationOptions(TranslationOptions):
    fields = ('nombre', 'cargo', 'descript')


class PaisesTranslationOptions(TranslationOptions):
    fields = ('nombre',)


class ContactoSeccionTranslationOptions(TranslationOptions):
    fields = ('cabecera', 'titulo', 'descript')


class LibroSeccionTranslationOptions(TranslationOptions):
    fields = ('cabecera', 'descript', 'pie')


class PaypalInfoTranslationOptions(TranslationOptions):
    fields = ('deposito',)

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


# Primera version
translator.register(TranslaterDicc, TranslaterDiccTranslationOptions)
translator.register(InfoSite, InfoSiteTranslationOptions)
translator.register(Sliders, SlidersTranslationOptions)
translator.register(PorqueElegirnos, PorqueElegirnosTranslationOptions)
translator.register(Conocenos, ConocenosTranslationOptions)
translator.register(EllosOpinan, EllosOpinanTranslationOptions)
translator.register(Paises, PaisesTranslationOptions)
translator.register(ContactoSeccion, ContactoSeccionTranslationOptions)
translator.register(LibroSeccion, LibroSeccionTranslationOptions)
translator.register(PaypalInfo, PaypalInfoTranslationOptions)
