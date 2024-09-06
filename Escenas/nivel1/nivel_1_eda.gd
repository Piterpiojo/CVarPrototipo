extends Control

const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 

func _ready() -> void:
	$AnimationPlayer.play("entrada")

func _on_v_pressed() -> void:
	reproducir(SonidoExito)
	$AnimationPlayer.play("correcto")



func reproducir(sonido):
	$AudioStreamPlayer.stream=sonido
	$AudioStreamPlayer.play()


func _on_f_pressed() -> void:
	reproducir(SonidoFallo)


func cambiar_escena():
	get_tree().change_scene_to_file("res://Escenas/menu_e/menue2.tscn")
