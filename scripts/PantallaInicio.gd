extends Control
const niveles = ["res://Escenas/nivel1/identificacion.tscn",
"res://Escenas/nivel2/Registro.tscn",
"res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn",
"res://Escenas/nivel4-sistemas_cv/nivel_4.tscn",
"res://Escenas/nivel5/nivel5.tscn",
"res://Escenas/nivel6/seccion6a.tscn"
]
var nivel= 0

func _on_iniciar_pressed():
	nivel= CargaArchivos.cargar_avance()
	print(nivel)
	get_tree().change_scene_to_file(nivel)

func cambiar():
	get_tree().change_scene_to_file(niveles[nivel])

func _on_salir_pressed():
	get_tree().quit()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scripts/CargarDialogos/cargarDialogos.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel2/Registro.tscn")


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


func _on_button_9_pressed():
	get_tree().change_scene_to_file("res://Escenas/nivel6/seccion6a.tscn")


func _on_inicio_pressed():
	nivel= CargaArchivos.cargar_avance()
	$AnimationPlayer.play("splash")



func _on_opciones_pressed():
	pass # Replace with function body.
