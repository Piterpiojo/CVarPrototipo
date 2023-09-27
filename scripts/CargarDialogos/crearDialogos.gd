extends Control
#
var Dialogo_nivel= {}

func crear_personaje_emocion():
	var Personaje_y_Emocion : Array
	Personaje_y_Emocion.append($personaje.text)
	Personaje_y_Emocion.append($emocion.text)
	return Personaje_y_Emocion

func crear_diccionario():
	Dialogo_nivel[$dialogo.text]= crear_personaje_emocion()

func _on_cargar_pressed():
	crear_diccionario()
	CargaArchivos.guardar(Dialogo_nivel,$nivel.text)


