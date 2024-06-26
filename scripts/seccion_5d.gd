extends Control
var bandera1=false
var actualizarLabel= false
var fase2= false
var eventoTimer=false
var logrosNivel
func _ready():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d")
	$CuadroDialogo.comenzar()
	guardar_avances()
	logrosNivel=CargaArchivos.logros["5"]

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true

func guardar_avances():
	CargaArchivos.guardar_avance(1, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(5,75)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if actualizarLabel:
		$time.text = "Segundos antes del Fin de la humanidad: " + str("%d" % $Timer.time_left)
		if($Timer.time_left <11 and !eventoTimer):
			eventoTimer=true
			$AudioStreamPlayer.play()
			$AudioStreamPlayer2.play()
			$AudioStreamPlayer3.play()
			$AnimationPlayer.play("el_temblor")
	if $CuadroDialogo.indice_dialogo == 4 and !bandera1:
		actualizarLabel=true
		$time.visible=true
		$Timer.start()
		bandera1=true
		$CuadroDialogo.acelerar_musica(2)
	if($CuadroDialogo.visible == false and fase2):
		get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5_db.tscn")
	


func _on_timer_timeout():
	actualizarLabel=false
	$time.queue_free()
	evaluar_texto()

func evaluar_texto():
	var texto =$ScrollContainer/TextureRect/texto_usuario.text
	$CuadroDialogo.indice_dialogo = 0
	$CuadroDialogo.habilitar_dialogo()
	$CuadroDialogo.acelerar_musica(1)
	$AnimationPlayer.play("RESET")
	if(texto.length() == 0):
		$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d-0")
		$CuadroDialogo.comenzar()
	if(texto.length() > 0 and texto.length() < 50):
		$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d-50")
		$CuadroDialogo.comenzar()
	if(texto.length() > 256):
		$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d-257")
		$CuadroDialogo.comenzar()
	if(!logrosNivel[2]):
		$Logro.fijar_logro("Sobreviviente del apocalipsis", "Pasa la prueba de escribir rápido de Ave de cualquier forma.")
		logrosNivel[2]= true
		CargaArchivos.logros["5"]= logrosNivel
		CargaArchivos.guardar_logros()
	fase2 =true

	
