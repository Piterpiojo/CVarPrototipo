extends Control
var nivel= 0

func _ready():
	CargaArchivos.cargar_logros()
	$Estatico.play("default")
	$AnimationPlayer.play("inicio")

func _on_salir_pressed():
	get_tree().quit()


func _on_inicio_pressed():
	$AnimationPlayer.play("splash")


func cambiar():
	get_tree().change_scene_to_file("res://Escenas/Selector_niveles.tscn")

func _on_abrir_explorer_pressed():
	OS.shell_open("https://www.unpaz.edu.ar/")


func _on_button_pressed():
	OS.shell_open("https://cvar.sicytar.mincyt.gob.ar/auth/index.jsp")
