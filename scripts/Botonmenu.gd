extends Button
var pausa
var cuadro_dialogo

func _ready():
	pausa=get_parent().get_node("Pausa")
	cuadro_dialogo=get_parent().get_node("CuadroDialogo")

func _on_pressed():
	pausa.visible=true
	get_parent().get_tree().paused=true


func _on_mouse_exited():
	cuadro_dialogo.habilitado=true


func _on_mouse_entered():
	cuadro_dialogo.habilitado=false
