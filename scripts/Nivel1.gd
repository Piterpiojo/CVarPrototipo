extends Control

const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 

func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel1")
	$CuadroDialogo.comenzar()

func _on_nuevo_usuario_pressed():
	$AudioStreamPlayer2D.stream=SonidoExito
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("negro")
	
	
func cambiar_escena():
	get_tree().change_scene_to_file("res://Escenas/nivel2/Registro.tscn")


func _on_olvido_contrasenia_pressed():
	$AudioStreamPlayer2D.stream=SonidoFallo
	$AudioStreamPlayer2D.play()


func _on_ingresar_pressed():
	$AudioStreamPlayer2D.stream=SonidoFallo
	$AudioStreamPlayer2D.play()
