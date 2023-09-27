extends Node
var path = "user://Dialogos.json"
var data = {}
	
func cargar():
	if(FileAccess.file_exists(path)):
		var archivo = FileAccess.open(path,FileAccess.READ);
		var text = archivo.get_as_text()
		data = JSON.parse_string(text)
		print("cargado con exito")
		archivo.close()
	else:
		return

func guardar():
	var archivo
	archivo = FileAccess.open(path,FileAccess.WRITE)
	archivo.store_string(JSON.stringify(data,"\t"))
	print("guardado con exito")
	archivo.close()
