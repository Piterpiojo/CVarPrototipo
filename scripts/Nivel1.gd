extends Control


func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel1")
	$CuadroDialogo.comenzar()

func _on_nuevo_usuario_pressed():
	get_tree().change_scene_to_file("res://Escenas/Registro.tscn")
