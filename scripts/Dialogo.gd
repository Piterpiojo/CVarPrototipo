extends Node
var indice_dialogo = 0
var habilitado :bool = true
var dialogos = []
var pausa : bool = false
const usuario = preload("res://ui/dialogousuario2.png")
const ave = preload("res://ui/dialogopersonaje2.png")
var cuadro
var letra = 0
var modulateAcutal
var completo = false
var logro = false
var esUnico=false

func deshabilitar():
	habilitado = false
func habilitar():
	habilitado = true
	
	
func cambiar_anim(nombre):
	$Container/Sprite2D.play(nombre)

func acelerar_musica(valor):
	$AudioStreamPlayer.pitch_scale=valor

func _ready():
	cuadro = get_node(".")
	$DialogoText.text = ""
	modulateAcutal=self.modulate.a
	$AudioStreamPlayer.volume_db= CargaArchivos.config["volumen"]

	
	

func comenzar():
	Mostrar_Linea(indice_dialogo)
	
func Mostrar_Linea(indice):
	$Timer.start()
	$Container/Sprite2D.play(dialogos[indice]["emocion"])
	dialogos[indice]["importante"]=false
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
	$prueba.text = "Id :" + str(indice_dialogo)
	if(Input.is_action_just_pressed("click") and habilitado and !esUnico):
		if completo:
			sig_dialogo()
			letra = 0
		else:
			$Timer.stop()
			$DialogoText.text= dialogos[indice_dialogo]["texto"]
			completo=true
	if(Input.is_action_just_pressed("click")):
		$click.play()
	if(Input.is_action_just_pressed("click") and esUnico):
		$DialogoText.text = ""
		desactivar_dialogo()
		esUnico=false
	if(Input.is_action_pressed("click_derecho") and habilitado):
		self.modulate.a = 0.20
	else:
		self.modulate.a=modulateAcutal
	if(pausa):
		$IndicacionText.text="Esperando..."
	else:
		$IndicacionText.text="Click para continuar"
		
	control_progress_bar()
	
func control_progress_bar():
	$Importante/ProgressBar.value=$enfriamiento_importante.time_left
	if($Importante/ProgressBar.value == 0):
		$Importante/ProgressBar.visible=false
	else:
		$Importante/ProgressBar.visible = true

func dialogo_actual():
	return indice_dialogo

func sig_dialogo():
	if !pausa:
		letra=0
		$DialogoText.text = ""
		indice_dialogo += 1
		if indice_dialogo < len(dialogos):
			Mostrar_Linea(indice_dialogo)
		else:
			desactivar_dialogo()
			$Timer.stop()
			$AudioStreamPlayer.gameplay_play()

func dialogo_anterior():
	if !pausa and indice_dialogo >0:
		letra=0
		$DialogoText.text = ""
		indice_dialogo -=1
		Mostrar_Linea(indice_dialogo)

func habilitar_dialogo():
	pausa = false
	self.visible= true
	habilitado = true
	$Timer.start()

func mostrar_dialogo_unico(texto,pj):
	if !logro:
		logro=true
	esUnico=true
	self.visible=true
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

func mostrar_sin_habilitar(texto,pj):
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
	$Timer.stop()
	pausa = true
	self.visible = false
	habilitado = false
	letra=0

func bajar_volumen():
	$AudioStreamPlayer.volume_db-=20
	await(get_tree().create_timer(3).timeout)
	$AudioStreamPlayer.volume_db += 20

func _on_timer_timeout():
	if(letra < dialogos[indice_dialogo]["texto"].length()):
		completo = false
		$DialogoText.text +=  dialogos[indice_dialogo]["texto"][letra]
		letra +=1 
	else:
		completo = true



func _on_button_pressed():
	habilitado=false
	if(contiene_importante() and !pausa):
		var i=0
		for dialogo in dialogos:
			if dialogo["importante"]:
				mostrar_sin_habilitar(dialogo["texto"],dialogo["personaje"])
				letra = 0
				dialogo["importante"]=false
				$Timer.stop()
				break
			i+=1
			indice_dialogo=i
			saltar_dialogo()
		$enfriamiento_importante.start()
		$Importante.disabled=true
	elif(!contiene_importante()):
		$Importante.disabled=true	

func saltar_dialogo():
	if !pausa:
		$DialogoText.text = ""
		if indice_dialogo < len(dialogos):
			pass
		else:
			desactivar_dialogo()
			$Timer.stop()
			$AudioStreamPlayer.gameplay_play()

func _on_button_mouse_entered():
	habilitado= false

func contiene_importante():
	
	for dialogo in dialogos:
		if dialogo["importante"]:
			return true
		
	return false



func _on_button_mouse_exited():
	habilitado = true


func _on_curiosidad_mouse_entered():
	habilitado = false


func _on_curiosidad_mouse_exited():
	habilitado = true


func desactivar_importante(valor:bool):
	$Importante.disabled = valor
	if(valor):
		$enfriamiento_importante.stop()

func _on_enfriamiento_importante_timeout():
	$Importante.disabled=false
