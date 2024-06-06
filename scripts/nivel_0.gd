extends Node2D
var banderas=[false,false,false,false,false,false]
var logrosNivel
var progreso = 0
var EspaciosTriangulo=[false,false,false]
var banderaTriangulo= false
const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
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
	elif($CuadroDialogo.indice_dialogo==45 and !banderaTriangulo):
		$AnimationPlayer.play("Triangulo")
		banderaTriangulo=true
	elif($CuadroDialogo.indice_dialogo==48 and !banderas[4]):
		$CuadroDialogo.sig_dialogo()
		$CuadroDialogo.desactivar_dialogo()
		banderas[4]=true
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
	elif(comprobar_triangulo()):
		$CuadroDialogo.habilitar_dialogo()
		


func comprobar_triangulo():
	return EspaciosTriangulo[0] and EspaciosTriangulo[1] and EspaciosTriangulo[2]
func pasar_menu():
	get_tree().change_scene_to_file("res://Escenas/Selector_niveles.tscn")

func guardar_avances():
	CargaArchivos.guardar_avance(0, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(0,progreso)
	
func _on_color_rect_2_mouse_entered():
	$CuadroDialogo.pausa =false
	$ColorRect2.visible = false
	$CuadroDialogo.sig_dialogo()


func _on__area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area.is_in_group("correcto") and !EspaciosTriangulo[0] and !area.seleccionado):
		$"Triangulo/1/Texto".text=area.texto
		area.queue_free()
		EspaciosTriangulo[0]=true
		reproducir_exito()
	else:
		area.global_position= area.pos_inicial


func _on__area_entered(area):
	if(area.is_in_group("correcto") and !EspaciosTriangulo[1] and !area.seleccionado):
		$"Triangulo/2/Texto".text=area.texto
		area.queue_free()
		EspaciosTriangulo[1]=true
		reproducir_exito()
	else:
		area.global_position= area.pos_inicial


func reproducir_exito():
	$Sonidos.stream=SonidoExito
	$Sonidos.play()

func reproducir_fallo():
	$Sonidos.stream=SonidoFallo
	if !$Sonidos.playing:
		$Sonidos.play()
func _on__area3_entered(area):
	if(area.is_in_group("correcto") and !EspaciosTriangulo[2] and  !area.seleccionado):
		$"Triangulo/3/Texto".text=area.texto
		area.queue_free()
		EspaciosTriangulo[2]=true
		reproducir_exito()
	else:
		area.global_position= area.pos_inicial

