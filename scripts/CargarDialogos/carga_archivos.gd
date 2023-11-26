extends Node
const path = "res://dialogos/"
const save= "res://guardado.json"
var data = []
var nivel= {"nivel":0}

func cargar(nombre):
	if(FileAccess.file_exists(path + nombre + ".json")):
		var archivo = FileAccess.open(path + nombre + ".json",FileAccess.READ);
		var text = archivo.get_as_text()
		data = JSON.parse_string(text)
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

func cargar_avance():
	if(FileAccess.file_exists(save)):
		var archivo = FileAccess.open(save,FileAccess.READ)
		var text = archivo.get_as_text()
		nivel=JSON.parse_string(text)
		archivo.close()
		return nivel["nivel"]
	else:
		guardar_avance(0)
	
func guardar_avance(_nivel):
	nivel["nivel"]=_nivel
	var archivo
	archivo = FileAccess.open(save,FileAccess.WRITE)
	archivo.store_string(JSON.stringify(nivel))
	archivo.close()
