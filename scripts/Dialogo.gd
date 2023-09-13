extends Node
var indice_dialogo = 0
var dialogos = [
	"Personaje: ¡Hola! Me alegra verte interesado en la investigación científica y tecnológica en Argentina.",
	"Personaje: Permíteme explicarte sobre el CVar, que es el Registro Unificado y Normalizado de Datos Curriculares.",
	"Personaje: El CVar es una plataforma que recopila información de los profesionales que trabajan en estas áreas en diversas instituciones.",
	"Personaje: Su objetivo principal es proporcionar información valiosa para la toma de decisiones y la planificación en estos campos tan importantes.",
	"Personaje: Mediante el CVar, se centraliza la información curricular, lo que facilita la colaboración entre investigadores y la identificación de expertos.",
	"Personaje: Esto también ayuda a que las instituciones puedan identificar áreas de fortaleza y necesidad en términos de recursos humanos.",
	"Personaje: Además, el CVar contribuye a una mayor visibilidad de la producción científica y tecnológica del país a nivel nacional e internacional.",
	"Personaje: Si eres parte de esta comunidad, asegúrate de mantener tus datos actualizados en el CVar para contribuir al desarrollo del país.",
	"Personaje: ¡Espero que esta explicación te haya sido útil! Si tienes más preguntas, no dudes en preguntar."
]

func _ready():
	Mostrar_Linea(indice_dialogo)

func Mostrar_Linea(indice):
	$DialogoText.text = dialogos[indice]


func _physics_process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		sig_dialogo()
		
func sig_dialogo():
	indice_dialogo += 1
	if indice_dialogo < len(dialogos):
		Mostrar_Linea(indice_dialogo)
	else:
		queue_free()
