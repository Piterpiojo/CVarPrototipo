extends Control
var horas: int = 48
var minutos: int = 59
var segundos: int =59
var bandera :bool =false

func _ready():
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$CuadroDialogo.dialogos= CargaArchivos.cargar("nivel3")
	$CuadroDialogo.comenzar()

func _process(_delta):
	eventos()

func eventos():
	if $CuadroDialogo.indice_dialogo ==1 and !bandera:
		$AnimationPlayer.play("mostrar_foto")
		$Usuario.visible = true
		bandera= true
	elif $CuadroDialogo.indice_dialogo == 3:
		$AnimationPlayer.stop()
		$Usuario.visible=false
		$"NicePngEmail-icon-png-transparent903587".visible=true
		bandera=false
	elif $CuadroDialogo.indice_dialogo == 4 and !bandera:
		tiempo()
		bandera=true
	elif $CuadroDialogo.indice_dialogo == 7 and !bandera:
		$espera.start()
		$CuadroDialogo.pausa=true
		bandera=true
	else:
		bandera=false
	

func tiempo():
	$reloj.visible= true
	$segundos.start(1)

func acelerar():
	$minutos.start(0.05)
	$segundos.wait_time = 0.05
func _on_segundos_timeout():
	segundos-=1
	if(segundos == 0):
		minutos-=1
		segundos = 59
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$segundos.start()


func _on_minutos_timeout():
	minutos-=1
	if(minutos == 0):
		horas-=1
		minutos = 59
	$minutos.start()


func _on_espera_timeout():
	$CuadroDialogo.pausa=false
	$CuadroDialogo.sig_dialogo()
