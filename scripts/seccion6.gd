extends Control
var bandera1=false
var contador=0

func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("seccion6")
	$CuadroDialogo.comenzar()

func _process(delta):
	if($CuadroDialogo.indice_dialogo ==1 and !bandera1):
		$AnimationPlayer.play("deslizar")
		bandera1=true

func eliminar_login():
	$Node2D/TextureRect.queue_free()

func eliminar_inicio():
	$Node2D/TextureRect2.queue_free()

func _on_button_pressed():
	$AnimationPlayer.play("deslizar2")
	$CuadroDialogo.mostrar_dialogo_unico("Presiona actualizar 3 veces","Ave")


func _on_recargar_pressed():
	contador +=1
	if contador> 2:
		$Node2D/TextureRect3/ColorRect.visible=true
		$Node2D/TextureRect3/visualizar.disabled=false


func _on_visualizar_pressed():
	pass # Replace with function body.
