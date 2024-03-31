extends Control
var avances
const imagenes=["res://Imagenes/identificacion/Identificación de Usuario-12.png",
"res://Imagenes/RegistroUsuario/Registro de Usuario-12.png",
"res://Imagenes/recuperar_contrasenia/cambio_contrasenia12.png",
"res://Imagenes/Sistemas_CV/Sistemas-12.png",
"res://Imagenes/seccion5/seccion5a-12.png",
"res://Imagenes/seccion6/seccion6.png"]

const niveles = ["res://Escenas/nivel1/identificacion.tscn",
"res://Escenas/nivel2/Registro.tscn",
"res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn",
"res://Escenas/nivel4-sistemas_cv/nivel_4.tscn",
"res://Escenas/nivel5/nivel5.tscn",
"res://Escenas/nivel6/seccion6a.tscn"
]

func _ready():
	avances = CargaArchivos.cargar_avance()
	if(avances == null):
		get_tree().reload_current_scene()
	mover_porcentaje()
	CargaArchivos.cargar_logros()
	
	
	
	
func mover_porcentaje():
	for i in range(6):
		print()
		if(avances[str(i+1)] > 99):
			$Control.get_child(i).button_pressed = true
		$Control.get_child(i).get_child(0).value=avances[str(i+1)]


func cargar(ruta):
	get_tree().change_scene_to_file(ruta)

func _on_c_1_pressed():
	cargar(niveles[0])


func _on_c_2_pressed():
	cargar(niveles[1])


func _on_c_3_pressed():
	cargar(niveles[2])


func _on_c_4_pressed():
	cargar(niveles[3])


func _on_c_5_pressed():
	var progreso5 = CargaArchivos.cargar_avance()["5"]
	if progreso5 == 0:
		cargar(niveles[4])
	elif progreso5 >= 25 and progreso5 < 50:
		cargar("res://Escenas/nivel5/seccion_5_b.tscn")
	elif progreso5 >= 50 and progreso5 < 75:
		cargar("res://Escenas/nivel5/seccion_5c.tscn")
	elif progreso5 >= 75 and progreso5 < 80:
		cargar("res://Escenas/nivel5/seccion_5d.tscn")
	else:
		cargar("res://Escenas/nivel5/seccion_5_db.tscn")


func _on_c_6_pressed():
	cargar(niveles[5])


func _on_c_1_mouse_entered():
	$TextureRect.texture = preload(imagenes[0])
	vista_logros(1)

func _on_c_2_mouse_entered():
	$TextureRect.texture = preload(imagenes[1])
	vista_logros(2)

func _on_c_3_mouse_entered():
	$TextureRect.texture = preload(imagenes[2])
	vista_logros(3)


func _on_c_4_mouse_entered():
	$TextureRect.texture = preload(imagenes[3])
	vista_logros(4)


func _on_c_5_mouse_entered():
	$TextureRect.texture = preload(imagenes[4])
	vista_logros(5)


func _on_c_6_mouse_entered():
	$TextureRect.texture = preload(imagenes[5])
	vista_logros(6)

func vista_logros(index):
	var indice= 0
	var logros = CargaArchivos.logros[str(index)]
	for i in $VBoxContainer.get_children():
		if(logros[indice]):
			i.modulate = "ffffff"
		else:
			i.modulate ="5c5c5c"
		indice+=1
