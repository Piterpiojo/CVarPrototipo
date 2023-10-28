extends Node
var indice_dialogo = 0
var habilitado :bool = true
var dialogos = []
var pausa : bool = false
var usuario = preload("res://ui/dialogousuario2.png")
var ave = preload("res://ui/dialogopersonaje2.png")
var cuadro
func deshabilitar():
	habilitado = false
func habilitar():
	habilitado = true

func _ready():
	cuadro = get_node(".")
	
	

func comenzar():
	Mostrar_Linea(indice_dialogo)
	
func Mostrar_Linea(indice):
	$DialogoText.text = dialogos[indice]["texto"]
	$Container/Sprite2D.play(dialogos[indice]["emocion"])
	if(dialogos[indice]["personaje"]=="Usuario"):
		$Container/Sprite2D.visible =false
		$personaje.visible=false
		$Usuario.visible=true
		cuadro.texture= usuario
	else:
		$Container/Sprite2D.visible =true
		$personaje.visible=true
		$Usuario.visible=false
		cuadro.texture=ave


func _process(_delta):
	if(Input.is_action_just_pressed("click") and habilitado):
		sig_dialogo()
	if(pausa):
		$IndicacionText.text="Esperando..."
	else:
		$IndicacionText.text="Click para continuar"

func dialogo_actual():
	return indice_dialogo

func sig_dialogo():
	if !pausa:
		indice_dialogo += 1
		if indice_dialogo < len(dialogos):
			Mostrar_Linea(indice_dialogo)
		else:
			desactivar_dialogo()

func habilitar_dialogo():
	pausa = false
	self.visible= true
	habilitado = true

func mostrar_dialogo_unico(texto,pj):
	habilitar_dialogo()
	$DialogoText.text = texto
	if(pj=="Usuario"):
		$Container/Sprite2D.visible =false
		$personaje.visible=false
		$Usuario.visible=true
		cuadro.texture= usuario
	else:
		$Container/Sprite2D.visible =true
		$personaje.visible=true
		$Usuario.visible=false
		cuadro.texture=ave

func desactivar_dialogo():
	pausa = true
	self.visible = false
	habilitado = false

