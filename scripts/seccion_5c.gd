extends Control
var bandera = false
var pos_inicial_insti
var pos_inicial_bucar
var puede_terminar=false
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
var progreso = 0
func _ready():
	$CuadroDialogo.dialogos= CargaArchivos.cargar("nivel5c")
	$CuadroDialogo.comenzar()
	pos_inicial_insti = $ScrollContainer/TextureRect/institucion.global_position
	pos_inicial_bucar = $ScrollContainer/TextureRect/buscar.global_position
	for i in provincias:
		$ScrollContainer/TextureRect/provincia.add_item(i)
	for i in partido:
		$ScrollContainer/TextureRect/partido.add_item(i)
	guardar_avances()
		
func guardar_avances():
	CargaArchivos.guardar_avance(1, $CuadroDialogo.indice_dialogo, 50)
	
func _process(_delta):
	if$CuadroDialogo.indice_dialogo > 2 and !bandera:
		flotar()
		$ayuda.cambiar_texto("Busca 'Instituto de Aviación Ícaro'")
		bandera=true

func _on_static_body_2d_body_entered(body):
	body.linear_velocity = body.linear_velocity * -1

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true



func flotar():
	$ScrollContainer/TextureRect/institucion.freeze=false
	$ScrollContainer/TextureRect/buscar.freeze=false


func _on_button_pressed():
	$CuadroDialogo.mostrar_dialogo_unico("Qué aburrido eres, ni dan ganas de jugar contigo","ave")
	$ScrollContainer/TextureRect/institucionSeleccionada.text = $ScrollContainer/ca/Label.text
	
	$Timer.start()

func _on_button_2_pressed():
	$CuadroDialogo.mostrar_dialogo_unico("Lo sabía, es tu destino!","Ave")
	$ScrollContainer/TextureRect/institucionSeleccionada.text = $ScrollContainer/ca/Label2.text
	$Timer.start()


func _on_button_4_pressed():
	$CuadroDialogo.mostrar_dialogo_unico("¡Cuidado con cruzar el espacio aéreo romano!","Ave")
	$ScrollContainer/TextureRect/institucionSeleccionada.text = $ScrollContainer/ca/Label3.text
	$CuadroDialogo.cambiar_anim("capitan")
	$Timer.start()



func _on_button_3_pressed():
	$CuadroDialogo.mostrar_dialogo_unico(" ¡Que la fuerza te acompañe!... Oh no… a nuestros abogados no les va a gustar esa referencia…","Ave")
	$ScrollContainer/TextureRect/institucionSeleccionada.text = $ScrollContainer/ca/Label4.text
	$CuadroDialogo.cambiar_anim("starwars")
	$Timer.start()

func _on_buscar_pressed():
	if($ScrollContainer/TextureRect/institucion/institucion.text=="Instituto de Aviación Ícaro"):
		$ScrollContainer/TextureRect.visible= false
		$"ScrollContainer/ca".visible=true
		$ScrollContainer/TextureRect/institucion.freeze=true
		$ScrollContainer/TextureRect/buscar.freeze=true
		$ScrollContainer/TextureRect/buscar.global_position = pos_inicial_bucar
		$ScrollContainer/TextureRect/institucion.global_position = pos_inicial_insti
		$AudioStreamPlayer.stream=sondioExito
		$AudioStreamPlayer.play()
		$CuadroDialogo.mostrar_dialogo_unico("Excelente habilidades de vuelo capitán! Muy bien, ahora solo queda seleccionar alguno de los departamentos, normalmente, tendrás que prestar atención a que fuera el que perteneces, trata de elegir el que más te llame la atención al menos 
","Ave")
		$ayuda.cambiar_texto("Selecciona el departamento al que perteneces Abajo")
	else:
		$CuadroDialogo.mostrar_dialogo_unico("Instituto de Aviación Ícaro es lo que hay que escribir","Ave")
		$AudioStreamPlayer.stream=sonidoError
		$AudioStreamPlayer.play()


func _on_timer_timeout():
	$AnimationPlayer.play("anegro")
	
func cambiar_escena():
	get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5d.tscn")
func ultimo_dialogo():
	$CuadroDialogo.mostrar_dialogo_unico("Termina de completar los datos así podremos avanzar mi estimado usuario de velas de cera, cuéntame un poco de tu experiencia en el instituto icaro y terminar de completar los datos, y como siempre, si algo no lo sabes ¡lo inventas! 
","Ave")
	$ayuda.cambiar_texto("Termina de completar los campos")
	puede_terminar=true



func _on_guardar_pressed():
	if puede_terminar:
		$AnimationPlayer.play("fin")
