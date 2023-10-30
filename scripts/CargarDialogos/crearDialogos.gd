extends Control

var Dialogo_nivel=[]

func crear_mensaje(personaje,texto,emocion):
	var mensaje={
		"personaje":personaje,
		"texto":texto,
		"emocion":emocion
	}
	Dialogo_nivel.append(mensaje)

func _on_cargar_pressed():
	crear_mensaje($personaje.text,$dialogo.text,$emocion.text)
	CargaArchivos.guardar(Dialogo_nivel,$nivel.text)


func _on_verprueba_pressed():
	if($nivel.text !=""):
		$CuadroDialogo.indice_dialogo=0
		$CuadroDialogo.visible= true
		$CuadroDialogo.dialogos=CargaArchivos.cargar($nivel.text)
		$CuadroDialogo.Mostrar_Linea(0)
		$CuadroDialogo.habilitar_dialogo()



func _on_emocion_item_selected(index):
	$Sprite2D.play($emocion.text)


func _on_button_pressed():
	$CuadroDialogo.mostrar_dialogo_unico($dialogo.text,$personaje.text)
