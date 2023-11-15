extends Control
var bandera1=false
var contador=0
var bandera2=false
var bandera3=false
const sonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
const sonidoError=preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("seccion6")
	$CuadroDialogo.comenzar()

func _process(_delta):
	if($CuadroDialogo.indice_dialogo ==1 and !bandera1):
		$AnimationPlayer.play("deslizar")
		bandera1=true
	elif($CuadroDialogo.indice_dialogo ==5 and !bandera2):
		$AnimationPlayer.play("deslizar4")
		bandera2=true
	elif($CuadroDialogo.indice_dialogo == 12 and !bandera3):
		$AnimationPlayer.play("deslizar5")
		bandera3=true
	

func eliminar_login():
	$Node2D/TextureRect.queue_free()

func eliminar_inicio():
	$Node2D/TextureRect2.queue_free()

func _on_button_pressed():
	$AudioStreamPlayer.stream=sonidoExito
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("deslizar2")
	$CuadroDialogo.mostrar_dialogo_unico("Presiona actualizar 3 veces","Ave")


func _on_recargar_pressed():
	contador +=1
	if contador> 2:
		$Node2D/TextureRect3/ColorRect.visible=true
		$Node2D/TextureRect3/visualizar.disabled=false
		$AudioStreamPlayer.stream=sonidoExito
		$AudioStreamPlayer.play()


func _on_visualizar_pressed():
	$AudioStreamPlayer.stream=sonidoExito
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("deslizar3")
	$CuadroDialogo.indice_dialogo =0
	$CuadroDialogo.dialogos=CargaArchivos.cargar("seccion6Ab")
	$CuadroDialogo.comenzar()
	$CuadroDialogo.habilitar_dialogo()


func _on_imprimir_pressed():
	get_tree().change_scene_to_file("res://Escenas/fin.tscn")
