extends Control
var nivel= 0

func _ready():
	CargaArchivos.cargar_logros()

func _on_salir_pressed():
	get_tree().quit()


func _on_inicio_pressed():
	get_tree().change_scene_to_file("res://Escenas/Selector_niveles.tscn")


func _on_opciones_pressed():
	nivel= CargaArchivos.cargar_avance()
	$AnimationPlayer.play("splash")


func _on_abrir_explorer_pressed():
	OS.shell_open("https://www.unpaz.edu.ar/")


func _on_button_pressed():
	OS.shell_open("https://cvar.sicytar.mincyt.gob.ar/auth/index.jsp")
