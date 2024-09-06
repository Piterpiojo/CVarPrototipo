extends Control

const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 

func _ready() -> void:
	pass # Replace with function body.


func _on_v_pressed() -> void:
	reproducir(SonidoExito)



func reproducir(sonido):
	$AudioStreamPlayer.stream=sonido
	$AudioStreamPlayer.play()


func _on_f_pressed() -> void:
	reproducir(SonidoFallo)


func cambiar_escena():
	pass
