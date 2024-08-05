extends Control

var bandera = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("introduccion")
	$CuadroDialogo.comenzar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $CuadroDialogo.indice_dialogo > 2 and ! bandera:
		$AnimationPlayer.play("negro")
		bandera= true

func cambiar_escena():
	get_tree().change_scene_to_file("res://Escenas/Selector_niveles.tscn")
