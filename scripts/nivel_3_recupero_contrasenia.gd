extends Control
var horas: int = 48
var minutos: int = 59
var segundos: int =59
var errores =0
var bandera1 :bool =false
var bandera2 :bool =false
var bandera3 :bool =false
var bandera4 :bool =false
var bandera5 :bool =false
var bandera6 : bool = false
var bandera7 : bool = false
var bandera8 : bool = false
var banderaMail:bool = false
var banderaFin : bool = false
var SonidoReloj= preload("res://sonidos/Musica y sonidos a utilizar/toggle_004.ogg")
var SonidoMail=preload("res://sonidos/Musica y sonidos a utilizar/toggle_002.ogg")
var SonidoFoto = preload("res://sonidos/Musica y sonidos a utilizar/error_007.ogg")
var SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
var SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 

func _ready():
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$CuadroDialogo.dialogos= CargaArchivos.cargar("nivel3")
	$CuadroDialogo.comenzar()
	CargaArchivos.guardar_avance(2)

func _process(_delta):
	eventos()

func eventos():
	if $CuadroDialogo.indice_dialogo ==1 and !bandera1:
		$AnimationPlayer.play("mostrar_foto")
		$Usuario.visible = true
		$AudioStreamPlayer.stream=SonidoFoto
		$AudioStreamPlayer.play()
		bandera1= true
	elif $CuadroDialogo.indice_dialogo == 3 and !banderaMail:
		$AnimationPlayer.stop()
		$Usuario.visible=false
		$"NicePngEmail-icon-png-transparent903587".visible=true
		$AudioStreamPlayer.stream=SonidoMail
		$AudioStreamPlayer.play()
		banderaMail=true
	elif $CuadroDialogo.indice_dialogo == 4 and !bandera2:
		tiempo()
		bandera2=true
	elif $CuadroDialogo.indice_dialogo == 7 and !bandera3:
		$espera.start()
		$CuadroDialogo.pausa=true
		$CuadroDialogo.habilitado= false
		bandera3=true
	elif $CuadroDialogo.indice_dialogo == 11 and !bandera4:
		$espera.start()
		$CuadroDialogo.pausa=true
		$CuadroDialogo.habilitado= false
		$CuadroDialogo.letra=0
		bandera4=true
	elif $CuadroDialogo.indice_dialogo == 12 and !bandera5:
		acelerar()
		bandera5=true
	elif $CuadroDialogo.indice_dialogo== 16 and !bandera6:
		$reloj.visible= false
		$"NicePngEmail-icon-png-transparent903587".visible = false
		$contrasenia.visible=true
		pausar_y_ocultar_dialogo()
		bandera6 = true
	elif $CuadroDialogo.indice_dialogo == 26 and !bandera7:
		bandera7=true
		pausar_y_ocultar_dialogo()
		
	elif $CuadroDialogo.indice_dialogo == 29 and !bandera8:
		bandera8=true
		pausar_y_ocultar_dialogo()
		
	elif $CuadroDialogo.indice_dialogo == 30 and !banderaFin:
		$AnimationPlayer.play("fin")
		banderaFin=true


func pausar_y_ocultar_dialogo():
	$CuadroDialogo.pausa= true
	$CuadroDialogo.visible = false
	$CuadroDialogo.letra=0

func tiempo():
	$reloj.visible= true
	$segundos.start(1)

func acelerar():
	$minutos.start(0.05)
	$segundos.wait_time = 0.05
	$horas.start(0.05)
	
func _on_segundos_timeout():
	segundos-=1
	if(segundos == 0):
		minutos-=1
		segundos = 59
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$segundos.start()
	$AudioStreamPlayer.stream= SonidoReloj
	$AudioStreamPlayer.play()

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true

func _on_minutos_timeout():
	minutos-=1
	if(minutos < 0):
		horas-=1
		minutos = 59
	$minutos.start()


func _on_espera_timeout():
	reanudar_dialogo()
	$espera.stop()
	$CuadroDialogo.habilitado= true

func reanudar_dialogo():
	$CuadroDialogo.visible=true
	$CuadroDialogo.pausa=false
	$CuadroDialogo.sig_dialogo()

func _on_horas_timeout():
	horas-=1
	if(horas < 0):
		$minutos.stop()
		$segundos.stop()
		$horas.stop()
		$reloj.text="00:00:00"
	$horas.start()



func _on_ingresar_pressed():
	if$ScrollContainer/identificacion/contrasenia.text == "9O6LiNE5":
		$ScrollContainer/identificacion.queue_free()
		$ScrollContainer/TextureRect.visible=true
		$contrasenia.text= "9O6LiNE5"
		$CuadroDialogo.letra=0
		$AudioStreamPlayer.stream= SonidoExito
		$AudioStreamPlayer.play()
		reanudar_dialogo()
	else:
		errores +=1
		$ScrollContainer/identificacion/error.visible= true
		$AudioStreamPlayer.stream= SonidoFallo
		$AudioStreamPlayer.play()
		if(errores == 3):
			reanudar_dialogo()

func pasar_al_siguiente():
	get_tree().change_scene_to_file("res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn")

func _on_cambiar_pressed():
	if($ScrollContainer/TextureRect/contrasenia_anterior.text == "9O6LiNE5"):
		if($ScrollContainer/TextureRect/nueva.text == $ScrollContainer/TextureRect/repetir.text):
			reanudar_dialogo()
			$AudioStreamPlayer.stream= SonidoExito
			$AudioStreamPlayer.play()
		else:
			$ScrollContainer/TextureRect/error2.text="La contraseña no coincide"
			$AudioStreamPlayer.stream= SonidoFallo
			$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stream= SonidoFallo
		$AudioStreamPlayer.play()
		$ScrollContainer/TextureRect/error2.text = "contraseña Actual no coincide"
