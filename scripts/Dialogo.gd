extends Node
var indice_dialogo = 0
var habilitado :bool = true
var dialogos = []

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
	else:
		$Container/Sprite2D.visible =true


func _process(_delta):
	if(Input.is_action_just_pressed("click") and habilitado):
		sig_dialogo()

func dialogo_actual():
	return indice_dialogo

func sig_dialogo():
	indice_dialogo += 1
	if indice_dialogo < len(dialogos):
		Mostrar_Linea(indice_dialogo)
	else:
		desactivar_dialogo()

func habilitar_dialogo():
	self.visible= true
	habilitado = true

func mostrar_dialogo_unico(texto):
	habilitar_dialogo()
	$DialogoText.text = texto

func desactivar_dialogo():
	self.visible = false
	habilitado = false
