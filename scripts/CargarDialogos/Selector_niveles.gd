extends Control
var avances
const imagenes=["res://ui/separadoresnivel/separador0.png",
"res://ui/separadoresnivel/separador1.png",
"res://ui/separadoresnivel/separador2.png",
"res://ui/separadoresnivel/separador3.png",
"res://ui/separadoresnivel/separador4y5.png",
"res://ui/separadoresnivel/separador6.png"]

var nivel_a_cargar
#const niveles = ["res://Escenas/nivel1/identificacion.tscn",
#"res://Escenas/nivel2/Registro.tscn",
#"res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn",
#"res://Escenas/nivel4-sistemas_cv/nivel_4.tscn",
#"res://Escenas/nivel5/nivel5.tscn",
#"res://Escenas/nivel6/seccion6a.tscn",
#"res://Escenas/nivel0/nivel_0.tscn"
#]

const objetivos=["Que es CVAR","Gestión de Usuario y contraseña.",
"Gestión de datos personales.",
"Gestión de contraseña.",
"Sistemas del CVAR",
"Sistemas del CVAR parte 2",
"Impresión del CV."]

const niveles=["res://Escenas/nivel1/Nivel1_eda.tscn"]

const tooltips = {
	"0": ["completar el Capitulo 0"],
	"1": ["Iniciar el Capitulo 1","Presionar el botón de usuarios nuevos",
		"Ingresar datos de correo electrónico.",
		" Completar el Capitulo 1."],
	"2": ["Hacer que Ave limpie la pantalla de información.",
		" Completar un formulario con la información solicitada.",
		"Intentar resolver el captcha sin éxito.",
		"Resolver correctamente el captcha.",
		"Completar el Capitulo 2."],
	"3": ["Observar el retrato de Ave.",
		"Esperar el tiempo necesario para recibir el correo electrónico.",
		"Intentar ingresar la contraseña incorrectamente.",
		"Ingresar la contraseña correctamente.",
		"Completar el Capitulo 3."],
	"4": ["Tocar el botón esquivo.","Selecciona correctamente el país de emisión teniendo en cuenta el pasaporte.",
		"Completar los datos de residencia.",
		"Pasa la prueba de escribir rápido de Ave de cualquier forma.",
		"Completar el Capitulo 4 y 5."],
	"6": ["Presionar el botón de actualizar el currículum tres veces.",
		"Observar el currículum distorsionado.",
		"Observar las estadísticas del usuario.",
		"Imprimir el currículum.",
		"Completar el Capitulo 6."]
}
func _ready():
	CargaArchivos.cargar_logros()
	$AnimationPlayer.play("fade_")

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


func _on_c_6_pressed():
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=5
	vista_logros(0)


func _on_c_1_mouse_entered():
	$TextureRect.texture = preload(imagenes[1])
	animar_menu(1)

func _on_c_2_mouse_entered():
	$TextureRect.texture = preload(imagenes[2])
	animar_menu(2)

func _on_c_3_mouse_entered():
	$TextureRect.texture = preload(imagenes[3])
	animar_menu(3)


func _on_c_4_mouse_entered():
	$TextureRect.texture = preload(imagenes[4])
	animar_menu(4)


func _on_c_6_mouse_entered():
	$TextureRect.texture = preload(imagenes[5])
	animar_menu(6)

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

func animar_menu(nivel):
	$Objectivo.text=objetivos[nivel]
	vista_logros(nivel)
	$AnimationPlayer.play("fade")

func _on_c_0_mouse_entered():
	$TextureRect.texture = preload(imagenes[0])
	animar_menu(0)


func _on_button_pressed() -> void:
	$CambiarNivel.play("siguiente_nivel")
	nivel_a_cargar=0
