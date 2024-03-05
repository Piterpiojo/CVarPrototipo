extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("probandoimportantes")
	$CuadroDialogo.comenzar()
