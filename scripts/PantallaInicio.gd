extends Control
var nivel= 0
var mute=false
const mute_ui = "res://ui/botonvolumenoff.png"
const unmute_ui="res://ui/botonvolumenon.png"
var preaudio

func _ready():
	CargaArchivos.cargar_logros()
	$Estatico.play("default")
	$AnimationPlayer.play("inicio")
	inicializar()
	mute = CargaArchivos.config["mute"]
	$AudioStreamPlayer.playing=!mute
	preaudio= CargaArchivos.config["volumen"]

func inicializar():
	$AudioStreamPlayer.volume_db = CargaArchivos.config["volumen"]
	$opciones/HSlider.value = CargaArchivos.config["volumen"]
func _on_salir_pressed():
	$AnimationPlayer.play("salir")

func cerrar():
	JavaScriptBridge.eval("window.close()")
	get_tree().quit()

func _on_inicio_pressed():
	$AnimationPlayer.play("splash")


func cambiar():
	get_tree().change_scene_to_file("res://Escenas/Selector_niveles.tscn")

func _on_abrir_explorer_pressed():
	OS.shell_open("https://www.unpaz.edu.ar/")


func _on_button_pressed():
	OS.shell_open("https://cvar.sicytar.mincyt.gob.ar/auth/index.jsp")


func _on_mutear_pressed():
	mute = !mute
	if mute:
		$mutear.icon= preload(mute_ui)
		$AudioStreamPlayer.stop()
		CargaArchivos.config["volumen"]=-81
	else:
		$mutear.icon = preload(unmute_ui)
		$AudioStreamPlayer.play()
		CargaArchivos.config["volumen"]=preaudio
	CargaArchivos.guardar_config()


func _on_cerrar_pressed():
	$opciones.visible=false


func _on_opciones_pressed():
	$opciones.visible=true


func _on_h_slider_value_changed(value):
	$AudioStreamPlayer.volume_db=value
	CargaArchivos.config["volumen"]=value
	CargaArchivos.guardar_config()
	preaudio=value
	if(value < -30):
		$AudioStreamPlayer.volume_db=-81
