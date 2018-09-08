# -*- coding: utf-8 -*-
'''
import xlrd
workbook = xlrd.open_workbook('/home/ccapu/dirs.xls')
worksheet = workbook.sheet_by_name('Hoja2')
num_rows = worksheet.nrows - 1
num_cells = worksheet.ncols - 1
curr_row = -1
marca_instace = 0
ubic_instace = 0
dist_instace = 0

while curr_row < num_rows: # for each row
	curr_row += 1
	marca = {}
	tlfs = []
	modelo = {}
	row = worksheet.row(curr_row)
	if curr_row > 0: # don't want the first row because those are labels
		for col_ind, el in enumerate(row):
			# el.value = unicode(el.value).strip()
			if col_ind == 0:
				ubic_instace,created = Ubicaciones.objects.get_or_create(nombre=unicode(el.value).strip())
				ubic_instace.ubicacion = get_coors()
				ubic_instace.save()
				# modelo_instace = modelo
				print "Nombre : "+el.value
			elif col_ind == 1 or col_ind == 2:
				if type(el.value) == type(0.0):
					el.value = unicode(int(el.value)).strip()
				if el.value != "0":
					tlfs.append(el.value)
				if col_ind == 2:
					ubic_instace.telefonos = ', '.join(tlfs)
					ubic_instace.save()
			elif col_ind == 3 :
				print u"Dirección : "+el.value
				ubic_instace.direccion = unicode(el.value).strip()
				ubic_instace.save()
			elif col_ind == 4 :
				dist_instace, created = Distrito.objects.get_or_create(nombre=unicode(el.value).strip())
				ubic_instace.distrito = dist_instace
				ubic_instace.save()
				print u"Distrito : "+el.value
			elif col_ind == 5 :
				prov, created = Provincia.objects.get_or_create(nombre=unicode(el.value).strip())
				dist_instace.provincia = prov
				dist_instace.save()
				ubic_instace.provincia = prov
				ubic_instace.save()
				print u"Provincia : "+el.value
'''