extends Control



func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://Escenas/identificacion.tscn")


func _on_salir_pressed():
	get_tree().quit()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scripts/CargarDialogos/cargarDialogos.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Escenas/Registro.tscn")


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn")


func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel4-sistemas_cv/nivel_4.tscn")


func _on_button_6_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel5/nivel5.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5_b.tscn")


func _on_button_7_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5c.tscn") # Replace with function body.


func _on_button_8_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5d.tscn")
