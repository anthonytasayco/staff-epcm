# -*- coding: utf-8 -*-
# from django.conf import settings


CKEDITOR_UPLOAD_PATH = "ck-uploads/"

CKEDITOR_CONFIGS = {
    'default': {
        'skin': 'bootstrapck',
        'toolbar': [["Format", "Bold", "Italic", "Underline", "Strike", "SpellChecker"],
                ['NumberedList', 'BulletedList', "Indent", "Outdent", 'JustifyLeft', 'JustifyCenter',
                 'JustifyRight', 'JustifyBlock'],
                ["Image", "Table", "Link", "Unlink", "Anchor", "SectionLink", "Subscript", "Superscript"], ['Undo', 'Redo'], ["Source"],
                ["Maximize"]],
        'height': 150,
        # 'width': 300,
        # "removePlugins": "Bold",
    },
    'small': {
        'skin': 'bootstrapck',
        'toolbar': [["Format", "Bold", "Italic", "Underline", "Strike", "SpellChecker", "Link", "Unlink"],
                ['NumberedList', 'BulletedList', "Indent", "Outdent", 'JustifyLeft', 'JustifyCenter',
                 'JustifyRight', 'JustifyBlock'],
                 ['Undo', 'Redo'], ["Source"],
                ["Maximize"]],
        'height': 100,
        # 'width': auto,
        "removePlugins": "Bold",
    },
    'awesome_ckeditor': {
        'toolbar': 'Basic',
    },
}

