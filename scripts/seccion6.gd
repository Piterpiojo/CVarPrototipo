extends Control
var bandera1=false
var contador=0
var bandera2=false
var bandera3=false
var progreso = 0
const sonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
const sonidoError=preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
var logrosNivel
func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("seccion6")
	$CuadroDialogo.comenzar()
	guardar_avances()
	logrosNivel=CargaArchivos.logros["6"]

func guardar_avances():
	CargaArchivos.guardar_avance(6, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(6,progreso)

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true


func _process(_delta):
	if($CuadroDialogo.indice_dialogo ==1 and !bandera1):
		$AnimationPlayer.play("deslizar")
		progreso = 25
		bandera1=true
		guardar_avances()
	elif($CuadroDialogo.indice_dialogo ==5 and !bandera2):
		$AnimationPlayer.play("deslizar4")
		progreso = 50
		bandera2=true
		guardar_avances()
		if(!logrosNivel[1]):
			$Logro.fijar_logro("Por andar a las corridas….", "Observar el currículum distorsionado.")
			logrosNivel[1]= true
			CargaArchivos.logros["6"]= logrosNivel
			CargaArchivos.guardar_logros()
	elif($CuadroDialogo.indice_dialogo == 12 and !bandera3):
		$AnimationPlayer.play("deslizar5")
		if(!logrosNivel[2]):
			$Logro.fijar_logro("Algún día mi nombre estará ahí….", "Observar las estadísticas del usuario.")
			logrosNivel[2]= true
			CargaArchivos.logros["6"]= logrosNivel
			CargaArchivos.guardar_logros()
		progreso = 75
		guardar_avances()
		bandera3=true
	

func eliminar_login():
	$Node2D/TextureRect.queue_free()

func eliminar_inicio():
	$Node2D/TextureRect2.queue_free()

func _on_button_pressed():
	$AudioStreamPlayer.stream=sonidoExito
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("deslizar2")
	$CuadroDialogo.mostrar_dialogo_unico("Presiona [b]Actualizá tu CV[/b] 3 veces, luego selecciona [b][u]Visualizá online tu CV[/u][/b] ","Ave")


func _on_recargar_pressed():
	contador +=1
	if contador> 2:
		$Node2D/TextureRect3/ColorRect.visible=true
		$Node2D/TextureRect3/visualizar.disabled=false
		$AudioStreamPlayer.stream=sonidoExito
		$AudioStreamPlayer.play()
		if(!logrosNivel[0]):
			$Logro.fijar_logro("Apresurado", "Presionar el botón de actualizar el currículum tres veces.")
			logrosNivel[0]= true
			CargaArchivos.logros["6"]= logrosNivel
			CargaArchivos.guardar_logros()


func _on_visualizar_pressed():
	$AudioStreamPlayer.stream=sonidoExito
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("deslizar3")
	$CuadroDialogo.indice_dialogo =0
	$CuadroDialogo.dialogos=CargaArchivos.cargar("seccion6Ab")
	#$CuadroDialogo.Importante.disable=false
	$CuadroDialogo.comenzar()
	$CuadroDialogo.habilitar_dialogo()


func _on_imprimir_pressed():
	progreso= 100
	if(!logrosNivel[3]):
		$Logro.fijar_logro("¿Te puedo dejar mi cv?", "Imprimir el currículum.")
		logrosNivel[3]= true
		CargaArchivos.logros["6"]= logrosNivel
		CargaArchivos.guardar_logros()
	guardar_avances()
	$Timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Escenas/fin.tscn")
