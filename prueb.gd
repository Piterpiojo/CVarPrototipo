extends Node2D

func _ready():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("probandoimportantes")
	$CuadroDialogo.comenzar()
