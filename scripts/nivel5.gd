extends Control
var provincias =['--- Seleccionar ---', 'Buenos Aires', 'Capital Federal', 'Catamarca', 'Chaco', 'Chubut', 'Córdoba', 'Corrientes', 'Entre Ríos', 'Formosa', 'Jujuy', 'La Pampa', 'La Rioja', 'Mendoza', 'Misiones', 'Neuquén', 'Río Negro', 'Salta', 'San Juan', 'San Luis', 'Santa Cruz', 'Santa Fe', 'Santiago del Estero', 'Tierra del Fuego', 'Tucumán']
var partido = [
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
var cuadros_texto =[]
var bandera1= false
var bandera2= false
var bandera3 = false
const sondioExito= preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
const sonidoError=preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")

func _ready():
	for i in provincias:
		$"ScrollContainer/seccion-a/provincia".add_item(i)
	for i in partido:
		$"ScrollContainer/seccion-a/partido".add_item(i)
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel5")
	$CuadroDialogo.comenzar()
	buscar_cuadros($"ScrollContainer/seccion-a")
	print(cuadros_texto.size())


func buscar_cuadros(nodo):
	for child in nodo.get_children():
		if child is LineEdit:
			cuadros_texto.append(child)

func _process(delta):
	if($CuadroDialogo.indice_dialogo==2 and !bandera1):
		$AnimationPlayer.play("intro")
		bandera1=true
	elif($CuadroDialogo.indice_dialogo==12 and !bandera2):
		$CuadroDialogo.desactivar_dialogo()
		bandera2=true

func hay_campos_vacios():
	for text in cuadros_texto:
		if text is LineEdit:
			if(text.text == ""):
				return true
	return false

func _on_pais_pasaporte_toggled(button_pressed):
	if($"ScrollContainer/seccion-a/tipoDocumento".text !="Pasaporte" and !bandera3):
		$CuadroDialogo.habilitar_dialogo()
		$CuadroDialogo.sig_dialogo()
		$AudioStreamPlayer.play()
		$Peligro.visible=true
		$Timer.start()
		bandera3=true


func _on_timer_timeout():
	$Peligro.visible= false


func _on_guardar_pressed():
	if !hay_campos_vacios():
		get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5_b.tscn")
	else:
		$AudioStreamPlayer.stream=sonidoError
		$AudioStreamPlayer.play()
		$CuadroDialogo.mostrar_dialogo_unico("te falto algun campo","Ave")
