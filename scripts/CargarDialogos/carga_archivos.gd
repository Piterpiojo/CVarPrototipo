extends Node
const path = "res://dialogos/"
var data = {}
	
func cargar(nombre):
	if(FileAccess.file_exists(path+ nombre + ".json")):
		var archivo = FileAccess.open(path,FileAccess.READ);
		var text = archivo.get_as_text()
		data = JSON.parse_string(text)
		print("cargado con exito")
		archivo.close()
		return data
	else:
		return

func guardar(Data,nombre):
	var archivo
	archivo = FileAccess.open(path + nombre +".json",FileAccess.WRITE)
	archivo.store_string(JSON.stringify(Data,"\t"))
	print("guardado con exito")
	archivo.close()
