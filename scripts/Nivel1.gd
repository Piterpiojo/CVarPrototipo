extends Control
var logrosNivel

const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 

func _ready():
	$AnimationPlayer.play("Entrada")
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel1")
	$CuadroDialogo.comenzar()
	$ayuda.cambiar_texto("Da tu primer paso en Cvar, Regístrate")
	logrosNivel = CargaArchivos.logros["1"]
	if(!logrosNivel[0]):
		$Logro.fijar_logro("Ahora si es hora de actuar", " Iniciar el nivel 1.")
		logrosNivel[0]= true
		CargaArchivos.logros["1"]= logrosNivel
		CargaArchivos.guardar_logros()
		

func _on_nuevo_usuario_pressed():
	if(!logrosNivel[1]):
		$Logro.fijar_logro("Novato", "Presionar el botón de usuarios nuevos")
		logrosNivel[1]= true
		CargaArchivos.logros["1"]= logrosNivel
		CargaArchivos.guardar_logros()
	$AudioStreamPlayer2D.stream=SonidoExito
	$AudioStreamPlayer2D.play()
	CargaArchivos.establecer_progreso(1,100)
	$AnimationPlayer.play("negro")


func cambiar_escena():
	if(!logrosNivel[3]):
		$Logro.fijar_logro("¡Bienvenido!", "Completar el nivel 1")
		logrosNivel[3]= true
		CargaArchivos.logros["1"]= logrosNivel
		CargaArchivos.guardar_logros()
	get_tree().change_scene_to_file("res://Escenas/nivel2/Registro.tscn")

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		$Pausa.visible=true
		get_tree().paused=true

func _on_olvido_contrasenia_pressed():
	$AudioStreamPlayer2D.stream=SonidoFallo
	$AudioStreamPlayer2D.play()


func _on_ingresar_pressed():
	$AudioStreamPlayer2D.stream=SonidoFallo
	$AudioStreamPlayer2D.play()
