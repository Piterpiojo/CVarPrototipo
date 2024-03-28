extends Control
var cuadros_llenos : int = 0
var ya_ejecuto : bool = false
var respuesta_secreta
var contador_recarga : int = 0
var cuadros_texto=[]
var i = 0
const SonidoFallo= preload("res://sonidos/Musica y sonidos a utilizar/error_003.ogg")
const SonidoExito = preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg") 
func _ready():
	$AnimationPlayer.play("Entrada")
	buscar_cuadros($ScrollContainer/TextureRect)
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel2")
	$CuadroDialogo.comenzar()
	CargaArchivos.guardar_avance(1)

func eliminar_fake():
	$ScrollContainer/TextureRect/fake.queue_free()
	
func buscar_cuadros(nodo):
	for child in nodo.get_children():
		if child is LineEdit:
			cuadros_texto.append(child)

func _process(_delta):
	if(!ya_ejecuto):
		_ejecutar_evento()

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true

func vaciar_todo():
	for cuadro in cuadros_texto:
		if cuadro is LineEdit:
			cuadro.clear()
	vaciar_especificos()

func vaciar_especificos():
	$ScrollContainer/TextureRect/fecha/TextEdit3.clear()
	$ScrollContainer/TextureRect/fecha/TextEdit4.clear()
	$ScrollContainer/TextureRect/fecha/TextEdit5.clear()
	$ScrollContainer/TextureRect/Label18/TextEdit.clear()
	$ScrollContainer/TextureRect/repetir_repeticion/TextEdit.clear()
	$ScrollContainer/TextureRect/Label19/TextEdit.clear()

func _ejecutar_evento():
	if $CuadroDialogo.dialogo_actual() == 3:
		$CuadroDialogo.habilitado = false
		$AnimationPlayer.play("arreglar")
		ya_ejecuto = true
		$ayuda.cambiar_texto("Completa todos los campos y envialo para crear tu cuenta")

func cambiar_dialogo():
	$CuadroDialogo.sig_dialogo()

func hay_campos_vacios():
	for text in cuadros_texto:
		if text is LineEdit:
			if(text.text == ""):
				return true
	return false

func comprobar_respuesta():
	return $ScrollContainer/TextureRect/respuesta_secreta.text == $ScrollContainer/TextureRect/respuesta_secreta_nuevamente.text && $ScrollContainer/TextureRect/respuesta_secreta.text != ""

func comprobar_correo():
	return $ScrollContainer/TextureRect/correo.text == $ScrollContainer/TextureRect/repetir_correo.text and $ScrollContainer/TextureRect/repetir_correo.text == $ScrollContainer/TextureRect/repetir_repeticion/TextEdit.text && $ScrollContainer/TextureRect/repetir_repeticion/TextEdit.text !=""

func _on_enviar_pressed():
	if comprobar_respuesta():
		if(comprobar_correo()):
			if(!hay_campos_vacios()):
				if($ScrollContainer/TextureRect/nombre9.text== "w62bc"):
					llamar_dialogo("¡Felicidades!, pudiste poner toda tu información, ahora solo faltaría verificar tu contraseña. Acompañame.")
					$Timer.start()
					$AudioStreamPlayer.stream= SonidoExito
					$AudioStreamPlayer.play()
				else:
					llamar_dialogo("el [b]codigo de seguridad[/b] es incorrecto")
					$AudioStreamPlayer.stream= SonidoFallo
					$AudioStreamPlayer.play()
			else:
				llamar_dialogo("te falto completar algun campo")
				$AudioStreamPlayer.stream= SonidoFallo
				$AudioStreamPlayer.play()
		else:
			$CuadroDialogo.mostrar_dialogo_unico("error correo no coinciden","Ave")
			$AudioStreamPlayer.stream= SonidoFallo
			$AudioStreamPlayer.play()
	else:
		$CuadroDialogo.mostrar_dialogo_unico("Error respuesta secreta no coinciden","Ave")
		$AudioStreamPlayer.stream= SonidoFallo
		$AudioStreamPlayer.play()



func llamar_dialogo(texto):
	$CuadroDialogo.mostrar_dialogo_unico(texto,"Ave")

func _on_recargar_pressed():
	contador_recarga +=1
	if contador_recarga ==3:
		$ScrollContainer/TextureRect/Capcha.queue_free()
		$AudioStreamPlayer.stream= SonidoExito
		$AudioStreamPlayer.play()

func _on_timer_timeout():
	$AnimationPlayer.play("fin")

func pasar_al_siguiente():
	get_tree().change_scene_to_file("res://Escenas/nivel3-recupero/nivel_3_recupero_contrasenia.tscn")
	

func _on_nombre_2_gui_input(event):
	if(event is InputEventMouseButton):
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			i+=1
		if(i > 2):
			vaciar_todo()
			$AudioStreamPlayer.stream= SonidoFallo
			$AudioStreamPlayer.play()
			i = 0

func deshabilitar_entrada():
	$CuadroDialogo.deshabilitar()

func habilitar_entrada():
	$CuadroDialogo.habilitar()

func _on_nombre_2_focus_exited():
	i=0




func _on_area_2d_mouse_entered():
	if(!$CuadroDialogo.visible):
		$CuadroDialogo.mostrar_dialogo_unico("Solo deberías tocar la opción de [b]País de Emisión[/b] si seleccionamos [b]Pasaporte[/b].","Ave")
		$ScrollContainer/TextureRect/Area2D.queue_free()


func _on_advertencia_mouse_entered():
	if(!$CuadroDialogo.visible):
		$CuadroDialogo.mostrar_dialogo_unico("Ten MUCHO, MUCHO, [b]MUCHO[/b] cuidado con hacer dos clicks dentro de un cuadro de texto. Va a borrar toda tu información y realmente no queremos eso, ¿No?","Ave")
		$CuadroDialogo.bajar_volumen()
		$ScrollContainer/TextureRect/advertencia.queue_free()
	



