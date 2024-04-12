extends Control
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
var cuadros_texto =[]
var bandera1= false
var bandera2= false
var bandera3 = false
const sondioExito= preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
const sonidoError=preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
var progreso = 0
var logrosNivel

func _ready():
	for i in provincias:
		$"ScrollContainer/seccion-a/provincia".add_item(i)
	for i in partido:
		$"ScrollContainer/seccion-a/partido".add_item(i)
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel5")
	$CuadroDialogo.comenzar()
	buscar_cuadros($"ScrollContainer/seccion-a")
	logrosNivel=CargaArchivos.logros["5"]
	guardar_avances()

func guardar_avances():
	CargaArchivos.guardar_avance(5, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(5,progreso)

func buscar_cuadros(nodo):
	for child in nodo.get_children():
		if child is LineEdit:
			cuadros_texto.append(child)

func _process(_delta):
	if($CuadroDialogo.indice_dialogo==2 and !bandera1):
		$AnimationPlayer.play("intro")
		bandera1=true
	elif($CuadroDialogo.indice_dialogo==13 and !bandera2):
		$CuadroDialogo.desactivar_dialogo()
		$ayuda.cambiar_texto("Completa los campos")
		bandera2=true

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


func _on_pais_pasaporte_toggled(_button_pressed):
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
		progreso = 25
		guardar_avances()
		if(!logrosNivel[0]):
			$Logro.fijar_logro("Identidad nacional", "Selecciona correctamente el país de emisión teniendo en cuenta el pasaporte.")
			logrosNivel[0]= true
			CargaArchivos.logros["5"]= logrosNivel
			CargaArchivos.guardar_logros()
		$CuadroDialogo.mostrar_dialogo_unico("¡Creo que esto fue lo más difícil que hicimos hasta ahora, así que felicidades. Necesito un poco de agua virtual, nos vemos en el próximo capítulo.","IA")
	else:
		$AudioStreamPlayer.stream=sonidoError
		$AudioStreamPlayer.play()
		$CuadroDialogo.mostrar_dialogo_unico("te falto completar algun campo","Ave")


func _on_logro_timer_timeout():
	get_tree().change_scene_to_file("res://Escenas/nivel5/seccion_5_b.tscn")
