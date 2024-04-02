extends Control

var logrosNivel
# Called when the node enters the scene tree for the first time.
func _ready():
	logrosNivel=CargaArchivos.logros["6"]
	$AnimationPlayer.play("fin")
	CargaArchivos.establecer_progreso("6",100)
	CargaArchivos.guardar_avance("6",2)
	if(!logrosNivel[4]):
		$Logro.fijar_logro("GAME OVER", "Completar el nivel 6.")
		logrosNivel[4]= true
		CargaArchivos.logros["6"]= logrosNivel
		CargaArchivos.guardar_logros()
