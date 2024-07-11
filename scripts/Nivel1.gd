extends Control
var logrosNivel
var banderas=[false,false,false]
const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 
var progreso = 0

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
	if(banderas[2]):
		if(!logrosNivel[1]):
			$Logro.fijar_logro("Novato", "Presionar el botón de usuarios nuevos")
			logrosNivel[1]= true
			CargaArchivos.logros["1"]= logrosNivel
			CargaArchivos.guardar_logros()
		$AudioStreamPlayer2D.stream=SonidoExito
		$AudioStreamPlayer2D.play()
		progreso = 100
		CargaArchivos.establecer_progreso(1,progreso)
		$AnimationPlayer.play("negro")

func _process(delta):
	if $CuadroDialogo.indice_dialogo == 14 and !banderas[0]:
		banderas[0]=true
		$ScrollContainer/TextureRect/emails.visible=true
		progreso = 75
	elif $CuadroDialogo.indice_dialogo == 15 and !banderas[1]:
		banderas[1]=true
		$CuadroDialogo.desactivar_dialogo()


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


func pausar_y_ocultar_dialogo():
	$CuadroDialogo.pausa= true
	$CuadroDialogo.visible = false
	$CuadroDialogo.letra=0

func guardar_avances():
	CargaArchivos.guardar_avance(1, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(1,progreso)
	
func _on_usuario_text_changed():
	if($ScrollContainer/TextureRect/usuario.text == "johndoe@email.com"):
		$ayuda.cambiar_texto("Presiona [i]'Si es un usuario nuevo presione aquí'[/i] para [b]crear[/b] tu cuenta")
		banderas[2]=true
		$CuadroDialogo.habilitar_dialogo()
		$AudioStreamPlayer2D.stream=SonidoExito
		$AudioStreamPlayer2D.play()
		if(!logrosNivel[2]):
			$Logro.fijar_logro("¡Pasame tu MSN", "Ingresar datos de correo electrónico.")
			logrosNivel[2]= true
			CargaArchivos.logros["1"]= logrosNivel
			CargaArchivos.guardar_logros()
		progreso = 90
	elif $ScrollContainer/TextureRect/usuario.text == "abcdefghijklmnopqrstuvwxyz@email.com":
		$AudioStreamPlayer2D.stream=SonidoFallo
		$AudioStreamPlayer2D.play()
	elif $ScrollContainer/TextureRect/usuario.text == "tuberculo@mail.com":
		$AudioStreamPlayer2D.stream=SonidoFallo
		$AudioStreamPlayer2D.play()
