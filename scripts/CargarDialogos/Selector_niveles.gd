extends Control
var avances
const imagenes=["res://ui/separadoresnivel/separador0.png",
"res://ui/separadoresnivel/separador1.png",
"res://ui/separadoresnivel/separador2.png",
"res://ui/separadoresnivel/separador3.png",
"res://ui/separadoresnivel/separador4y5.png",
"res://ui/separadoresnivel/separador6.png"]

var nivel_a_cargar
const niveles = ["res://Escenas/nivel1/identificacion.tscn",
"res://Escenas/nivel2/Registro.tscn",
"res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn",
"res://Escenas/nivel4-sistemas_cv/nivel_4.tscn",
"res://Escenas/nivel5/nivel5.tscn",
"res://Escenas/nivel6/seccion6a.tscn",
"res://Escenas/nivel0/nivel_0.tscn"
]

const objetivos=[" En este nivel aprenderemos todos los datos concernientes a cómo la plataforma llegó a ser lo que es hoy en día.
","Gestión de Usuario y contraseña. Aprenderemos cómo unirnos a laplataforma.",
"Gestión de datos personales. Aprenderemos sobre los datos iniciales que aparecerán en la plataforma.",
"Gestión de contraseña. Conseguiremos que el sistema nos genera nuestra primera contraseña.",
"Sistemas del CVAR. Esta sección es la más amplia y veremos cómo formar
finalmente el que se convertirá en el CV propiamente dicho.",
"Sistemas del CVAR. Esta sección es la más amplia y veremos cómo formar
finalmente el que se convertirá en el CV propiamente dicho.",
"Impresión del CV: En esta área daremos los últimos retoques necesarios
para imprimir nuestro CV de forma física."]
const tooltips = {
	"0": ["completar el nivel 0"],
	"1": ["Iniciar el nivel 1","Presionar el botón de usuarios nuevos",
		"Ingresar datos de correo electrónico.",
		" Completar el nivel 1."],
	"2": ["Hacer que Ave limpie la pantalla de información.",
		" Completar un formulario con la información solicitada.",
		"Intentar resolver el captcha sin éxito.",
		"Resolver correctamente el captcha.",
		"Completar el nivel 2."],
	"3": ["Observar el retrato de Ave.",
		"Esperar el tiempo necesario para recibir el correo electrónico.",
		"Intentar ingresar la contraseña incorrectamente.",
		"Ingresar la contraseña correctamente.",
		" Repetir la nueva contraseña diez veces.",
		"Completar el nivel 3."],
	"4": ["Tocar el botón esquivo."],
	"5": ["Selecciona correctamente el país de emisión teniendo en cuenta el pasaporte.",
		"Completar los datos de residencia.",
		"Pasa la prueba de escribir rápido de Ave de cualquier forma.",
		"Completar el nivel 4 y 5."],
	"6": ["Presionar el botón de actualizar el currículum tres veces.",
		"Observar el currículum distorsionado.",
		"Observar las estadísticas del usuario.",
		"Imprimir el currículum.",
		"Completar el nivel 6."]
}
func _ready():
	avances = CargaArchivos.cargar_avance()
	if(avances == null):
		get_tree().reload_current_scene()
	mover_porcentaje()
	CargaArchivos.cargar_logros()
	
	
	
	
func mover_porcentaje():
	for i in range(7):
		if(avances[str(i)] > 99):
			$Control.get_child(i).button_pressed = true
		$Control.get_child(i).get_child(0).value=avances[str(i)]


func cargar():
	get_tree().change_scene_to_file(niveles[nivel_a_cargar])

func _on_c_1_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=0


func _on_c_2_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=1


func _on_c_3_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=2


func _on_c_4_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=3


func _on_c_5_pressed():
	$CambiarNivel.play("siguiente_nivel")
	var progreso5 = CargaArchivos.cargar_avance()["5"]
	nivel_a_cargar=4


func _on_c_6_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=5
	vista_logros(0)


func _on_c_1_mouse_entered():
	$TextureRect.texture = preload(imagenes[1])
	$Objectivo.text= objetivos[1]
	vista_logros(1)
	$AnimationPlayer.play("fade")

func _on_c_2_mouse_entered():
	$TextureRect.texture = preload(imagenes[2])
	vista_logros(2)
	$Objectivo.text= objetivos[2]
	$AnimationPlayer.play("fade")

func _on_c_3_mouse_entered():
	$TextureRect.texture = preload(imagenes[3])
	vista_logros(3)
	$Objectivo.text= objetivos[3]
	$AnimationPlayer.play("fade")


func _on_c_4_mouse_entered():
	$TextureRect.texture = preload(imagenes[4])
	vista_logros(4)
	$Objectivo.text= objetivos[4]
	$AnimationPlayer.play("fade")


func _on_c_5_mouse_entered():
	$TextureRect.texture = preload(imagenes[4])
	vista_logros(5)
	$Objectivo.text= objetivos[5]
	$AnimationPlayer.play("fade")


func _on_c_6_mouse_entered():
	$TextureRect.texture = preload(imagenes[5])
	vista_logros(6)
	$Objectivo.text= objetivos[6]
	$AnimationPlayer.play("fade")

func vista_logros(_index):
	var indice= 0
	var temp = 0
	var logros = CargaArchivos.logros[str(_index)]
	var tooltipnivel = tooltips[str(_index)]
	for i in $VBoxContainer.get_children():
		i.visible= false
		if(temp < logros.size()):
			i.visible = true
			i.tooltip_text = tooltipnivel[temp]
			if(logros[temp]):
				i.modulate = "ffffff"
			else:
				i.modulate ="5c5c5c"
			temp +=1
		indice+=1


func _on_c_0_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=6


func _on_c_0_mouse_entered():
	$TextureRect.texture = preload(imagenes[0])
	vista_logros(0)
	$Objectivo.text= objetivos[0]
	$AnimationPlayer.play("fade")
