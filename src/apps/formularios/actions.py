# -*- coding: utf-8 -*-

import csv
from unidecode import unidecode

from django.http import HttpResponse


def export_as_csv_action(description="Exporta la lista en un archivo csv",
						 fields=None, exclude=None, header=True):
	"""
		This function returns an export csv action
		'fields' and 'exclude' work like in django ModelForm
		'header' is whether or not to output the column names as the first row
	"""
	def export_as_csv(modeladmin, request, queryset):
		"""
			Generic csv export admin action.
			based on http://djangosnippets.org/snippets/2369/
		"""
		opts = modeladmin.model._meta
		field_names = set([field.name for field in opts.fields])
		if fields:
			fieldset = set(fields)
			field_names = field_names & fieldset
		elif exclude:
			excludeset = set(exclude)
			field_names = field_names - excludeset

		response = HttpResponse(content_type='text/plain')
		response['Content-Disposition'] = 'attachment; filename=%s.csv' % unicode(opts).replace('.', '_')

		writer = csv.writer(response)
		if header:
			writer.writerow(list(field_names))
		for obj in queryset:
			writer.writerow([unidecode(unicode(getattr(obj, field))) for field in field_names])
		return response
	export_as_csv.short_description = description
	return export_as_csv


from django.core.exceptions import PermissionDenied
from pyExcelerator import *
from StringIO import StringIO


def export_as_xls(modeladmin, request, queryset):
	"""
	Generic xls export admin action.
	"""
	if not request.user.is_staff:
		raise PermissionDenied
	opts = modeladmin.model._meta
	
	wb = Workbook()
	ws0 = wb.add_sheet('0')
	col = 0
	field_names = []
	# write header row
	for field in opts.fields:
		ws0.write(0, col, field.name)
		field_names.append(field.name)
		col = col + 1
	row = 1
	# Write data rows
	for obj in queryset:
		col = 0
		for field in field_names:
			val = unicode(getattr(obj, field)).strip()
			ws0.write(row, col, val)
			col = col + 1
		row = row + 1   

	f = StringIO()
	wb.save(f)
	f.seek(0)
	response = HttpResponse(f.read(), content_type='application/ms-excel')
	response['Content-Disposition'] = 'attachment; filename=%s.xls' % unicode(opts).replace('.', '_')
	return response
	
export_as_xls.short_description = "Export selected objects to XLS"