extends Node2D
const titulos = [
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
var parte2=false
var bandera1=false
var bandera2=false
var bandera3=false
var uno= false
var dos= false
var tres=false
var ocupadoEsp=[false,false,false]
var ocupadoIng=[false,false,false]

var sonidoCaida= preload("res://sonidos/Musica y sonidos a utilizar/jump1.ogg")
func _ready():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5Db")
	$CuadroDialogo.comenzar()
	congelar(true)
	for i in titulos:
		$ScrollContainer/TextureRect/siete.add_item(i)
		$ScrollContainer/TextureRect/seis.add_item(i)
		$ScrollContainer/TextureRect/tres.add_item(i)

func completas():
	var cantidad=0
	for i in ocupadoEsp:
		if(i):
			cantidad +=1
	for i in ocupadoIng:
		if(i):
			cantidad+=1
	return cantidad

func congelar(bul):
	for i in $ScrollContainer/TextureRect/palabras.get_children():
		if(i is RigidBody2D):
			i.freeze=bul

		
func nuevo_dialogo():
	$CuadroDialogo.dialogos = CargaArchivos.cargar("nivel5dc")
	$CuadroDialogo.indice_dialogo=0
	$CuadroDialogo.habilitar_dialogo()
	$CuadroDialogo.comenzar()
	parte2=true

func _process(_delta):
	if($CuadroDialogo.indice_dialogo == 6 and !bandera1):
		$AnimationPlayer.play("sacudelo")
		bandera1=true
		$ayuda.cambiar_texto("Organiza las áreas de actuación con los cuentos y su descripción, Quizá hay un orden")
	if($CuadroDialogo.indice_dialogo == 4 and !bandera2 and parte2):
		$CuadroDialogo.desactivar_dialogo()
		bandera2=true
		$ayuda.cambiar_texto("Arrasta las palabras clave relacionadas con las áreas de actuación")
	if($CuadroDialogo.indice_dialogo == 9 and !bandera3 and parte2):
		$AnimationPlayer.play("anegro")
		bandera3=true



func ir_al_nivel_seis():
	get_tree().change_scene_to_file("res://Escenas/nivel6/seccion6a.tscn")
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



func _on_siete_2_item_selected(_index):
	if($ScrollContainer/TextureRect/siete.text== "Los Siete Cabritillos y el Lobo" ):
		if($ScrollContainer/TextureRect/siete2.text == "Un lobo engaña a los cabritillos, pero el último los salva."):
			uno=true
	if uno and dos and tres:
		congelar(false)
		$AudioStreamPlayer.stream=sonidoCaida
		$AudioStreamPlayer.play()
		nuevo_dialogo()
		
func _on_seis_2_item_selected(_index):
	if($ScrollContainer/TextureRect/seis.text== "Los Seis Cisnes" ):
		if($ScrollContainer/TextureRect/seis2.text == "Una princesa teje camisas para liberar a sus hermanos cisnes."):
			dos=true
	if uno and dos and tres:
		congelar(false)
		$AudioStreamPlayer.stream=sonidoCaida
		$AudioStreamPlayer.play()
		nuevo_dialogo()

func _on_tres_2_item_selected(_index):
	if($ScrollContainer/TextureRect/tres.text=="Los Tres Cerditos"):
		if($ScrollContainer/TextureRect/tres2.text == "Tres cerditos construyen casas, el lobo las derriba, excepto la de ladrillos."):
			tres=true
	if uno and dos and tres:
		congelar(false)
		$AudioStreamPlayer.stream=sonidoCaida
		$AudioStreamPlayer.play()
		nuevo_dialogo()


func _on_texto_body_entered(body):
	if(body.is_in_group("espaniol") and !ocupadoEsp[0] and body.puedeSel):
		ocupadoEsp[0]=true
		body.puedeSel=false
		$ScrollContainer/TextureRect/Container2/texto.text=body.texto
		body.queue_free()
		if completas() ==6:
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()

func _on_texto_2_body_entered(body):
	if(body.is_in_group("espaniol") and !ocupadoEsp[1]  and body.puedeSel):
		body.puedeSel=false
		ocupadoEsp[1]=true
		$ScrollContainer/TextureRect/Container2/texto2.text=body.texto
		body.queue_free()
		if completas() ==6:
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()
		
func _on_texto_3_body_entered(body):
	if(body.is_in_group("espaniol") and !ocupadoEsp[2]  and body.puedeSel):
		body.puedeSel=false
		ocupadoEsp[2]=true
		$ScrollContainer/TextureRect/Container2/texto3.text=body.texto
		body.queue_free()
		if completas() ==6:
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()




func _on_ingles_body_entered(body):
	if(body.is_in_group("ingles") and !ocupadoIng[0]  and body.puedeSel):
		body.puedeSel=false
		ocupadoIng[0]=true
		$ScrollContainer/TextureRect/Container2/ingles.text=body.texto
		body.queue_free()
		if completas() ==6:
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()


func _on_ingles_2_body_entered(body):
	if(body.is_in_group("ingles") and !ocupadoIng[1]  and body.puedeSel):
		body.puedeSel=false
		ocupadoIng[1]=true
		$ScrollContainer/TextureRect/Container2/ingles2.text=body.texto
		body.queue_free()
		if completas() ==6:
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()


func _on_ingles_3_body_entered(body):
	if(body.is_in_group("ingles") and !ocupadoIng[2]  and body.puedeSel):
		body.puedeSel=false
		ocupadoIng[2]=true
		$ScrollContainer/TextureRect/Container2/ingles3.text=body.texto
		body.queue_free()
		if completas() ==6:
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()


