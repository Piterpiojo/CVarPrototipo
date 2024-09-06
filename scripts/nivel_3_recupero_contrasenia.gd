extends Control
var horas: int = 48
var minutos: int = 59
var segundos: int =59
var errores =0
var repeticiones= 0
var bandera1 :bool =false
var bandera2 :bool =false
var bandera3 :bool =false
var bandera4 :bool =false
var bandera5 :bool =false
var bandera6 : bool = false
var bandera7 : bool = false
var bandera8 : bool = false
var banderaMail:bool = false
var banderaFin : bool = true
var bandera16 = false
var contrasenias=0
const SonidoReloj= preload("res://sonidos/Musica y sonidos a utilizar/toggle_004.ogg")
const SonidoMail=preload("res://sonidos/Musica y sonidos a utilizar/toggle_002.ogg")
const SonidoFoto = preload("res://sonidos/Musica y sonidos a utilizar/error_007.ogg")
const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 

var logrosNivel

func _ready():
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$CuadroDialogo.dialogos= CargaArchivos.cargar("nivel3")
	$CuadroDialogo.comenzar()
	logrosNivel=CargaArchivos.logros["3"]

func _process(_delta):
	eventos()


func eventos():
	if $CuadroDialogo.indice_dialogo ==0 and !bandera1:
		$AnimationPlayer.play("mostrar_foto")
		$Usuario.visible = true
		$AudioStreamPlayer.stream=SonidoFoto
		$AudioStreamPlayer.play()
		bandera1= true
	elif $CuadroDialogo.indice_dialogo == 2 and !banderaMail:
		$AnimationPlayer.stop()
		$Usuario.visible=false
		$"NicePngEmail-icon-png-transparent903587".visible=true
		$AudioStreamPlayer.stream=SonidoMail
		$AudioStreamPlayer.play()
		banderaMail=true

		if(!logrosNivel[0]):
			$Logro.fijar_logro("El arte es subjetivo", "Observar el retrato de Ave.")
			logrosNivel[0]= true
			CargaArchivos.logros["3"]= logrosNivel
			CargaArchivos.guardar_logros()
	elif $CuadroDialogo.indice_dialogo == 3 and !bandera2:
		tiempo()
		bandera2=true
	elif $CuadroDialogo.indice_dialogo == 4 and !bandera3:
		$espera.start()
		$CuadroDialogo.pausa=true
		$CuadroDialogo.habilitado= false
		bandera3=true
		$ayuda.cambiar_texto("Espera a que se complete el tiempo")
	elif $CuadroDialogo.indice_dialogo == 5 and !bandera5:
		acelerar()
		bandera5=true
	elif $CuadroDialogo.indice_dialogo== 7 and !bandera6:
		$reloj.visible= false
		$"NicePngEmail-icon-png-transparent903587".visible = false
		$contrasenia.visible=true
		bandera6 = true
		$CuadroDialogo.desactivar_importante(true)
		if(!logrosNivel[1]):
			$Logro.fijar_logro("La paciencia es la clave", "Esperar el tiempo necesario para recibir el correo electrónico.")
			logrosNivel[1]= true
			CargaArchivos.logros["3"]= logrosNivel
			CargaArchivos.guardar_logros()
		$ayuda.cambiar_texto("ingresa la contraseña correctamente")

		
	elif $CuadroDialogo.indice_dialogo== 9 and !bandera16:
		pausar_y_ocultar_dialogo()
		bandera16=true
		
	elif $CuadroDialogo.indice_dialogo == 15 and !bandera7:
		bandera7=true
		$CuadroDialogo.desactivar_importante(false)
		pausar_y_ocultar_dialogo()
		$CuadroDialogo/Importante.disabled =false

	elif $CuadroDialogo.indice_dialogo == 21 and !bandera8:
		bandera8=true
		pausar_y_ocultar_dialogo()
		$ayuda.cambiar_texto("De menos de 16 caracteres, primera letra mayúscula y algún símbolo.")

	elif $CuadroDialogo.indice_dialogo == 21 and !banderaFin:
		if(!logrosNivel[4]):
			$Logro.fijar_logro("¡Que nadie se entere!", "Completar el nivel 3.")
			logrosNivel[4]= true
			CargaArchivos.logros["3"]= logrosNivel
			CargaArchivos.guardar_logros()
		banderaFin=true
		$AnimationPlayer.play("fin")
	elif contrasenias == 4 and banderaFin:
		reanudar_dialogo()
		banderaFin=false
		$AudioStreamPlayer.stream= SonidoExito
		$AudioStreamPlayer.play()
	elif $CuadroDialogo.indice_dialogo >2:
		$Usuario.visible=false
		

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
	$CuadroDialogo.sig_dialogo()
	$espera.stop()
	$CuadroDialogo.habilitado= true

func reanudar_dialogo():
	$CuadroDialogo.visible=true
	$CuadroDialogo.pausa=false

func _on_horas_timeout():
	horas-=1
	if(horas < 0):
		$minutos.stop()
		$segundos.stop()
		$horas.stop()
		$reloj.text="00:00:00"
	$horas.start()



func _on_ingresar_pressed():
	if$ScrollContainer/identificacion/contrasenia.text == "ABDeyZ":
		$ScrollContainer/identificacion.queue_free()
		$ScrollContainer/TextureRect.visible=true
		$contrasenia.queue_free()
		$ScrollContainer/TextureRect/contrasenias.visible=true
		$CuadroDialogo.letra=0
		$AudioStreamPlayer.stream= SonidoExito
		$AudioStreamPlayer.play()
		if(!logrosNivel[3]):
			$Logro.fijar_logro("Alfanumérico", "Ingresar la contraseña correctamente.")
			logrosNivel[3]= true
			CargaArchivos.logros["3"]= logrosNivel
			CargaArchivos.guardar_logros()
		reanudar_dialogo()
	else:
		if(!logrosNivel[2]):
			$Logro.fijar_logro("Cuidado que no se bloquee.", "Intentar ingresar la contraseña incorrectamente.")
			logrosNivel[2]= true
			CargaArchivos.logros["3"]= logrosNivel
			CargaArchivos.guardar_logros()
		$ayuda.cambiar_texto("ingresa la contraseña correctamente")
		errores +=1
		$ScrollContainer/identificacion/error.visible= true
		$AudioStreamPlayer.stream= SonidoFallo
		$AudioStreamPlayer.play()
		if(errores == 3):
			reanudar_dialogo()

func pasar_al_siguiente():
	get_tree().change_scene_to_file("res://Escenas/nivel4-sistemas_cv/nivel_4.tscn")

func _on_cambiar_pressed():
	if($ScrollContainer/TextureRect/contrasenia_anterior.text == "ABDeyZ"):
		if($ScrollContainer/TextureRect/nueva.text == $ScrollContainer/TextureRect/repetir.text):
			repeticiones +=1
			$AudioStreamPlayer.stream= SonidoExito
			$AudioStreamPlayer.play()
			$ScrollContainer/TextureRect/nueva.text = ""
			$ScrollContainer/TextureRect/repetir.text=""
			if(repeticiones>9):
				reanudar_dialogo()
				if(!logrosNivel[4]):
					$Logro.fijar_logro("¡Que nadie se entere!", "Completar el nivel 3.")
					logrosNivel[4]= true
					CargaArchivos.logros["3"]= logrosNivel
					CargaArchivos.guardar_logros()
		else:
			$ScrollContainer/TextureRect/error2.text="La contraseña no coincide"
			$AudioStreamPlayer.stream= SonidoFallo
			$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stream= SonidoFallo
		$AudioStreamPlayer.play()
		$ScrollContainer/TextureRect/error2.text = "contraseña Actual no coincide"


func _on_button_3_pressed():
	$ScrollContainer/TextureRect/contrasenias/Button3.disabled=true
	contrasenias+=1


func _on_button_5_pressed():
	$ScrollContainer/TextureRect/contrasenias/Button5.disabled=true
	contrasenias+=1


func _on_button_6_pressed():
	$ScrollContainer/TextureRect/contrasenias/Button6.disabled=true
	contrasenias+=1


func _on_button_4_pressed():
	$ScrollContainer/TextureRect/contrasenias/Button4.disabled=true
	contrasenias+=1
