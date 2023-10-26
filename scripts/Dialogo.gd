extends Node
var indice_dialogo = 0
var habilitado :bool = true
var dialogos = []
var pausa : bool = false

func deshabilitar():
	habilitado = false
func habilitar():
	habilitado = true

func comenzar():
	Mostrar_Linea(indice_dialogo)
	
func Mostrar_Linea(indice):
	$DialogoText.text = dialogos[indice]["texto"]
	$Container/Sprite2D.play(dialogos[indice]["emocion"])
	if(dialogos[indice]["personaje"]=="Usuario"):
		$Container/Sprite2D.visible =false
		$personaje.text= "Usuario"
	else:
		$Container/Sprite2D.visible =true
		$personaje.text = "Ave"


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

func mostrar_dialogo_unico(texto):
	habilitar_dialogo()
	$DialogoText.text = texto

func desactivar_dialogo():
	pausa = true
	self.visible = false
	habilitado = false

