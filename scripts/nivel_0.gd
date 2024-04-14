extends Node2D
var banderas=[false,false,false,false,false,false]
var logrosNivel
var progreso = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel0")
	$CuadroDialogo.comenzar()
	$AnimationPlayer.play("al_centro")
	logrosNivel = CargaArchivos.logros["0"]
	
func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		$Pausa.visible=true
		get_tree().paused=true
		
func logro(titulo, descripcion):
	$Logro.fijar_logro(titulo,descripcion)

func _process(_delta):
	if($CuadroDialogo.indice_dialogo == 1 and !banderas[0]):
		banderas[0]=true
		$AnimationPlayer.play("a_izq")
		progreso = 4
	elif($CuadroDialogo.indice_dialogo == 2 and !banderas[1]):
		banderas[1]=true
		$AnimationPlayer.play("a_der")
		progreso = 6
	elif($CuadroDialogo.indice_dialogo == 3 and !banderas[2]):
		banderas[2]=true
		progreso = 10
		$AnimationPlayer.play("RESET")
		guardar_avances()
	elif($CuadroDialogo.indice_dialogo==43 and !banderas[3]):
		banderas[3]=true
		$ColorRect2.visible = true
		$CuadroDialogo.pausa =true
		progreso = 60
		guardar_avances()
	elif($CuadroDialogo.indice_dialogo==48 and !banderas[4]):
		pass #para hacer la piramide
	elif($CuadroDialogo.indice_dialogo == 51 and ! banderas[5]):
		progreso = 100
		guardar_avances()
		if(!logrosNivel[0]):
			$Logro.fijar_logro("Historiador CVAR","Completaste el nivel 0")
			logrosNivel[0]=true
			CargaArchivos.logros["0"]= logrosNivel
			CargaArchivos.guardar_logros()
			CargaArchivos.establecer_progreso(0,100)
		$AnimationPlayer.play("a_negro")
		

func pasar_menu():
	get_tree().change_scene_to_file("res://Escenas/Selector_niveles.tscn")

func guardar_avances():
	CargaArchivos.guardar_avance(0, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(0,progreso)
	
func _on_color_rect_2_mouse_entered():
	$CuadroDialogo.pausa =false
	$ColorRect2.visible = false
	$CuadroDialogo.sig_dialogo()
