extends Control
var titulos = [
	"---------- Seleccionar ----------",
	"1 CIENCIAS NATURALES Y EXACTAS",
	"1.1 Matemáticas",
	"1.2 Ciencias de la Computación e Información",
	"1.3 Ciencias Físicas",
	"1.4 Ciencias Químicas",
	"1.5 Ciencias de la Tierra y relacionadas con el Medio Ambiente",
	"1.6 Ciencias Biológicas",
	"1.7 Otras Ciencias Naturales y Exactas",
	"2 INGENIERÍAS Y TECNOLOGÍAS",
	"2.1 Ingeniería Civil",
	"2.2 Ingeniería Eléctrica, Ingeniería Electrónica e Ingeniería de la Información",
	"2.3 Ingeniería Mecánica",
	"2.4 Ingeniería Química",
	"2.5 Ingeniería de los Materiales",
	"2.6 Ingeniería Médica",
	"2.7 Ingeniería del Medio Ambiente",
	"2.8 Biotecnología del Medio Ambiente",
	"2.9 Biotecnología Industrial",
	"2.10 Nanotecnología",
	"2.11 Otras Ingenierías y Tecnologías",
	"3 CIENCIAS MÉDICAS Y DE LA SALUD",
	"3.1 Medicina Básica",
	"3.2 Medicina Clínica",
	"3.3 Ciencias de la Salud",
	"3.4 Biotecnología de la Salud",
	"3.5 Otras Ciencias Médicas",
	"4 CIENCIAS AGRÍCOLAS",
	"4.1 Agricultura, Silvicultura y Pesca",
	"4.2 Producción Animal y Lechería",
	"4.3 Ciencias Veterinarias",
	"4.4 Biotecnología Agropecuaria",
	"4.5 Otras Ciencias Agrícolas",
	"5 CIENCIAS SOCIALES",
	"5.1 Psicología",
	"5.2 Economía y Negocios",
	"5.3 Ciencias de la Educación",
	"5.4 Sociología",
	"5.5 Derecho",
	"5.6 Ciencia Política",
	"5.7 Geografía Económica y Social",
	"5.8 Comunicación y Medios",
	"5.9 Otras Ciencias Sociales",
	"6 HUMANIDADES",
	"6.1 Historia y Arqueología",
	"6.2 Lengua y Literatura",
	"6.3 Filosofía, Ética y Religión",
	"6.4 Arte",
	"6.5 Otras Humanidades"
]
var bandera1=false

func _ready():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("Nivel5Db")
	$CuadroDialogo.comenzar()
	for i in titulos:
		$ScrollContainer/TextureRect/siete.add_item(i)
		$ScrollContainer/TextureRect/seis.add_item(i)
		$ScrollContainer/TextureRect/tres.add_item(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($CuadroDialogo.indice_dialogo == 6 and !bandera1):
		$AnimationPlayer.play("sacudelo")
		bandera1=true

func llenarCuadros():
	limpiar()
	cambiarValoresTitulos("--- Seleccionar ---")
	cambiarValoresTitulos("Los Seis Cisnes")
	cambiarValoresTitulos("Los Tres Cerditos")
	cambiarValoresTitulos("Los Siete Cabritillos y el Lobo")
	cambiarValoresLineas("Una princesa teje camisas para liberar a sus hermanos cisnes.")
	cambiarValoresLineas("Tres cerditos construyen casas, el lobo las derriba, excepto la de ladrillos.")
	cambiarValoresLineas("Un lobo engaña a los cabritillos, pero el último los salva.")


func limpiar():
	$ScrollContainer/TextureRect/siete.clear()
	$ScrollContainer/TextureRect/seis.clear()
	$ScrollContainer/TextureRect/tres.clear()
	
func cambiarValoresTitulos(texto):
	$ScrollContainer/TextureRect/siete.add_item(texto)
	$ScrollContainer/TextureRect/seis.add_item(texto)
	$ScrollContainer/TextureRect/tres.add_item(texto)
	
func cambiarValoresLineas(texto):
	$ScrollContainer/TextureRect/siete2.add_item(texto)
	$ScrollContainer/TextureRect/seis2.add_item(texto)
	$ScrollContainer/TextureRect/tres2.add_item(texto)



func _on_siete_2_item_selected(index):
	if($ScrollContainer/TextureRect/siete2.selected == 4 ):
		if($ScrollContainer/TextureRect/siete.selected == 3):
			print("bien")
