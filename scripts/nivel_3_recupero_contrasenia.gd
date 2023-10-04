extends Control
var horas: int = 48
var minutos: int = 59
var segundos: int =59


func _ready():
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	




func _on_segundos_timeout():
	segundos-=1
	if(segundos ==0):
		minutos-=1
		segundos = 59
	$reloj.text=str(horas) + ":"+ str(minutos) + ":"+ str(segundos)
	$segundos.start()
