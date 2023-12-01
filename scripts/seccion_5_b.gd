extends Control
var cuadros_texto=[]
var ya_lanzo=false
const provincias =['--- Seleccionar ---', 'Buenos Aires', 'Capital Federal', 'Catamarca', 'Chaco', 'Chubut', 'Córdoba', 'Corrientes', 'Entre Ríos', 'Formosa', 'Jujuy', 'La Pampa', 'La Rioja', 'Mendoza', 'Misiones', 'Neuquén', 'Río Negro', 'Salta', 'San Juan', 'San Luis', 'Santa Cruz', 'Santa Fe', 'Santiago del Estero', 'Tierra del Fuego', 'Tucumán']
const partido = [
		"---------- Seleccionar ----------",
		"25 de Mayo",
		"9 de Julio",
		"Adolfo Alsina",
		"Adolfo Gonzales Chaves",
		"Alberti",
		"Almirante Brown",
		"Arrecifes",
		"Avellaneda",
		"Ayacucho",
		"Azul",
		"Bahía Blanca",
		"Balcarce",
		"Baradero",
		"Benito Juárez",
		"Berazategui",
		"Berisso",
		"Bolívar",
		"Bragado",
		"Brandsen",
		"Campana",
		"Cañuelas",
		"Capitán Sarmiento",
		"Carlos Casares",
		"Carlos Tejedor",
		"Carmen de Areco",
		"Castelli",
		"Chacabuco",
		"Chascomús",
		"Chivilcoy",
		"Colón",
		"Coronel de Marina L. Rosales",
		"Coronel Dorrego",
		"Coronel Pringles",
		"Coronel Suárez",
		"Daireaux",
		"Dolores",
		"Ensenada",
		"Escobar",
		"Esteban Echeverría",
		"Exaltación de la Cruz",
		"Ezeiza",
		"Florencio Varela",
		"Florentino Ameghino",
		"General Alvarado",
		"General Alvear",
		"General Arenales",
		"General Belgrano",
		"General Guido",
		"General Juan Madariaga",
		"General La Madrid",
		"General Las Heras",
		"General Lavalle",
		"General Paz",
		"General Pinto",
		"General Pueyrredón",
		"General Rodríguez",
		"General San Martín",
		"General Viamonte",
		"General Villegas",
		"Guaminí",
		"Hipólito Yrigoyen",
		"Hurlingham",
		"Ituzaingó",
		"José C. Paz",
		"Junín",
		"La Costa",
		"La Matanza",
		"La Plata",
		"Lanús",
		"Laprida",
		"Las Flores",
		"Leandro N. Alem",
		"Lincoln",
		"Lobería",
		"Lobos",
		"Lomas de Zamora",
		"Luján",
		"Magdalena",
		"Maipú",
		"Malvinas Argentinas",
		"Mar Chiquita",
		"Marcos Paz",
		"Mercedes",
		"Merlo",
		"Monte",
		"Monte Hermoso",
		"Moreno",
		"Morón",
		"Navarro",
		"Necochea",
		"Olavarría",
		"Patagones",
		"Pehuajó",
		"Pellegrini",
		"Pergamino",
		"Pila",
		"Pilar",
		"Pinamar",
		"Presidente Perón",
		"Puán",
		"Punta Indio",
		"Quilmes",
		"Ramallo",
		"Rauch",
		"Rivadavia",
		"Rojas",
		"Roque Pérez",
		"Saavedra",
		"Saladillo",
		"Salliqueló",
		"Salto",
		"San Andrés de Giles",
		"San Antonio de Areco",
		"San Cayetano",
		"San Fernando",
		"San Isidro",
		"San Miguel",
		"San Nicolás",
		"San Pedro",
		"San Vicente",
		"Suipacha",
		"Tandil",
		"Tapalqué",
		"Tornquist",
		"Trenque Lauquen",
		"Tres Arroyos",
		"Tres de Febrero",
		"Tres Lomas",
		"Vicente López",
		"Villa Gesell",
		"Villarino",
		"Zárate",
		"OTRO"
	]
	
const sondioExito= preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
const sonidoError=preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel5b")
	$CuadroDialogo.comenzar()
	buscar_cuadros($ScrollContainer/TextureRect)
	print(cuadros_texto.size())
	for i in provincias:
		$ScrollContainer/TextureRect/provincia.add_item(i)
	for i in partido:
		$ScrollContainer/TextureRect/partido.add_item(i)

func buscar_cuadros(nodo):
	for child in nodo.get_children():
		if child is LineEdit and child.is_in_group("obligatorio"):
			cuadros_texto.append(child)

func hay_campos_vacios():
	for text in cuadros_texto:
		if text is LineEdit:
			if(text.text == ""):
				return true
	return false

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true


func _on_guardar_pressed():
	if(!hay_campos_vacios()):
		$CuadroDialogo.mostrar_dialogo_unico("Vaya ... y tu querías mi ayuda cuando lo llevabas bien claro…. Quizás en las siguientes secciones deberías hacer relevancia a  tu tremenda habilidad para localizar criptidos, estoy segura de que es un talento muy buscado en estas épocas modernas donde a uno le cuesta mucho discernir entre realidad y ficción, en fin, prosigamos.","Ave")
		$AudioStreamPlayer.stream=sondioExito
		$AudioStreamPlayer.play()
	else:
		$CuadroDialogo.mostrar_dialogo_unico("falta completar algun campo obligatorio","Ave")
		$AudioStreamPlayer.stream=sonidoError
		$AudioStreamPlayer.play()

func cambiarEscena():
	get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5c.tscn")



func _on_line_edit_16_focus_entered():
	if(!ya_lanzo and $ScrollContainer/TextureRect/calle.text != "" and $ScrollContainer/TextureRect/partido.text != "---------- Seleccionar ----------"):
		$ColorRect/Label2.text="¡¡¡Ultimo momento!!! La Luz mala fue avistada en la calle " + $ScrollContainer/TextureRect/calle.text + " en el partido de " + $ScrollContainer/TextureRect/partido.text 
		$AnimationPlayer.play("publicidad")
