# -*- coding: utf-8 -*-
from django.utils.encoding import force_unicode
import re

def strip_tags(value):
    """Returns the given HTML with all tags stripped."""
    return re.sub(r'<[^>]*?>', '', force_unicode(value))
