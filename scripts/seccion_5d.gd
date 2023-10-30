extends Control
var bandera1=false
var actualizarLabel= false
var fase2= false
# Called when the node enters the scene tree for the first time.
func _ready():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d")
	$CuadroDialogo.comenzar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if actualizarLabel:
		$time.text = "Segundos antes del Fin de la humanidad: " + str("%d" % $Timer.time_left)
	if $CuadroDialogo.indice_dialogo == 4 and !bandera1:
		actualizarLabel=true
		$time.visible=true
		$Timer.start()
		bandera1=true
	if($CuadroDialogo.visible == false and fase2):
		get_tree().change_scene_to_file("res://Escenas/pantalla_inicio.tscn")
	


func _on_timer_timeout():
	actualizarLabel=false
	$time.queue_free()
	evaluar_texto()

func evaluar_texto():
	var texto =$ScrollContainer/TextureRect/texto_usuario.text
	$CuadroDialogo.indice_dialogo = 0
	$CuadroDialogo.habilitar_dialogo()
	if(texto.length() == 0):
		$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d-0")
		$CuadroDialogo.comenzar()
	if(texto.length() > 0 and texto.length() < 50):
		$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d-50")
		$CuadroDialogo.comenzar()
	if(texto.length() > 256):
		$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5d-257")
		$CuadroDialogo.comenzar()
	fase2 =true

	
