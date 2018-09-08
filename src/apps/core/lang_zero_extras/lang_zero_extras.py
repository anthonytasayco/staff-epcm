# -*- coding: utf-8 -*-

import unicodedata, re

def slugify(str):
	slug = unicodedata.normalize("NFKD", unicode(str)).encode("ascii", "ignore")
	slug = re.sub(r"[^\w]+", " ", slug)
	slug = "-".join(slug.lower().strip().split())
	return slug[0:175]

def get_uuslug_translation(Model, title, slug):
	nro = 1
	volver = True
	slug_base = slugify(title)
	slug_new = slug_base
	while volver:
		res = Model.objects.filter(translations__slug=slug_new)
		if res.count() > 0 :
			if slug == slug_new:
				return slug_new
		else:
			return slug_new
		slug_new = '%s-%s' % (slug_base, nro)
		nro = nro + 1