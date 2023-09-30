extends Control



func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://Escenas/identificacion.tscn")


func _on_salir_pressed():
	get_tree().quit()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scripts/CargarDialogos/cargarDialogos.tscn")
