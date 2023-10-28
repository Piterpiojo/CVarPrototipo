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
var banderaFin : bool = false


func _ready():
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$CuadroDialogo.dialogos= CargaArchivos.cargar("nivel3")
	$CuadroDialogo.comenzar()

func _process(_delta):
	eventos()

func eventos():
	if $CuadroDialogo.indice_dialogo ==1 and !bandera1:
		$AnimationPlayer.play("mostrar_foto")
		$Usuario.visible = true
		bandera1= true
	elif $CuadroDialogo.indice_dialogo == 3:
		$AnimationPlayer.stop()
		$Usuario.visible=false
		$"NicePngEmail-icon-png-transparent903587".visible=true
	elif $CuadroDialogo.indice_dialogo == 4 and !bandera2:
		tiempo()
		bandera2=true
	elif $CuadroDialogo.indice_dialogo == 7 and !bandera3:
		$espera.start()
		$CuadroDialogo.pausa=true
		bandera3=true
	elif $CuadroDialogo.indice_dialogo == 11 and !bandera4:
		$espera.start()
		$CuadroDialogo.pausa=true
		bandera4=true
	elif $CuadroDialogo.indice_dialogo == 12 and !bandera5:
		acelerar()
		bandera5=true
	elif $CuadroDialogo.indice_dialogo== 15 and !bandera6:
		$reloj.visible= false
		$"NicePngEmail-icon-png-transparent903587".visible = false
		$contrasenia.visible=true
		pausar_y_ocultar_dialogo()
		bandera6 = true
	elif $CuadroDialogo.indice_dialogo == 25 and !bandera7:
		bandera7=true
		pausar_y_ocultar_dialogo()
		
	elif $CuadroDialogo.indice_dialogo == 28 and !bandera8:
		bandera8=true
		pausar_y_ocultar_dialogo()
		
	elif $CuadroDialogo.indice_dialogo == 29 and !banderaFin:
		$AnimationPlayer.play("fin")
		banderaFin=true


func pausar_y_ocultar_dialogo():
	$CuadroDialogo.pausa= true
	$CuadroDialogo.visible = false

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


func _on_minutos_timeout():
	minutos-=1
	if(minutos < 0):
		horas-=1
		minutos = 59
	$minutos.start()


func _on_espera_timeout():
	reanudar_dialogo()
	$espera.stop()

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
		reanudar_dialogo()
	else:
		errores +=1
		$ScrollContainer/identificacion/error.visible= true
		if(errores == 3):
			reanudar_dialogo()

func pasar_al_siguiente():
	get_tree().quit()

func _on_cambiar_pressed():
	if($ScrollContainer/TextureRect/contrasenia_anterior.text == "9O6LiNE5"):
		if($ScrollContainer/TextureRect/nueva.text == $ScrollContainer/TextureRect/repetir.text):
			reanudar_dialogo()
		else:
			$ScrollContainer/TextureRect/error2.text="La contraseña no coincide"
	else:
		$ScrollContainer/TextureRect/error2.text = "contraseña Actual no coincide"
