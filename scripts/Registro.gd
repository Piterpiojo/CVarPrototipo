extends Control
const dialogo = [
	"A: (entusiasmada) Ahora que la página está de vuelta, ¡vamos a crear tu cuenta! Solo necesitamos llenar algunos datos personales primero",
	"...",
	"A: ¿Eso? Ni siquiera te preocupes, yo me encargo de eso en un parpadeo.",
	"",
	"A: ¿Te parece bien esto? Son solo algunos datos personales que necesitamos para continuar. Ten cuidado al seleccionar país de emisión, solo deberías tocar la opción de País de Emisión si seleccionamos Pasaporte."
]
var cuadros_llenos : int = 0
var ya_ejecuto : bool = false
var respuesta_secreta
var contador_recarga : int = 0
var cuadros_texto=[]
var i = 0

func _ready():
	$CuadroDialogo.dialogos = dialogo
	$CuadroDialogo.comenzar()
	buscar_cuadros($ScrollContainer/TextureRect)
	conectar_todo()

func eliminar_fake():
	$ScrollContainer/TextureRect/fake.queue_free()
	
func buscar_cuadros(nodo):
	for child in nodo.get_children():
		if child is LineEdit:
			cuadros_texto.append(nodo)
	print(cuadros_texto.size())

func _process(delta):
	if(!ya_ejecuto):
		_ejecutar_evento()

func vaciar_todo():
	for cuadro in cuadros_texto:
		cuadro.text = ""

func _ejecutar_evento():
	if $CuadroDialogo.dialogo_actual() == 3:
		$CuadroDialogo.habilitado = false
		$AnimationPlayer.play("arreglar")
		ya_ejecuto = true
		
func cambiar_dialogo():
	$CuadroDialogo.sig_dialogo()
	$CuadroDialogo.habilitado=true






func _on_pasaporte_pressed():
	if $ScrollContainer/TextureRect/cuilBox.button_pressed == true:
		$CuadroDialogo.mostrar_dialogo_unico("solo deberías tocar la opción de País de Emisión si seleccionamos Pasaporte.")




func _on_enviar_pressed():
	if $ScrollContainer/TextureRect/respuesta_secreta.text == $ScrollContainer/TextureRect/respuesta_secreta_nuevamente.text:
		if($ScrollContainer/TextureRect/correo.text == $ScrollContainer/TextureRect/repetir_correo.text and $ScrollContainer/TextureRect/repetir_correo.text == $ScrollContainer/TextureRect/repetir_repeticion/TextEdit.text):
			llamar_dialogo("¡Felicidades!, pudiste poner toda tu información, ahora solo faltaría verificar tu contraseña. Acompañame.")
			$Timer.start()
		else:
			$CuadroDialogo.mostrar_dialogo_unico("error correo")
			print("error correo")
	else:
		print("error respuesta secreta")
		$CuadroDialogo.mostrar_dialogo_unico("Error respuesta")


func _on_respuesta_secreta_nuevamente_focus_exited():
	print("salio")


func _on_respuesta_secreta_nuevamente_focus_entered():
	$CuadroDialogo.mostrar_dialogo_unico("Ten MUCHO, MUCHO, MUCHO cuidado con hacer dos clicks dentro de un cuadro de texto.  Va a borrar toda tu información y realmente no queremos eso, ¿No?")

func llamar_dialogo(texto):
	$CuadroDialogo.mostrar_dialogo_unico(texto)


func _on_recargar_pressed():
	contador_recarga +=1
	if contador_recarga >3:
		$CuadroDialogo.mostrar_dialogo_unico("deberia mostrar lo correcto")



func _on_timer_timeout():
	$AnimationPlayer.play("fin")


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "fin"):
		get_tree().quit()




func _on_nombre_2_gui_input(event):
	if(event is InputEventMouseButton):
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			i+=1
			print("tocado" + str(i))
			

func conectar_todo():
	for nodo in cuadros_texto:
		if nodo is LineEdit:
			nodo.connect("focus_exited","_on_nombre_2_focus_exited")
			nodo.connect("gui_input","_on_nombre_2_gui_input")
	
func _on_nombre_2_focus_exited():
	i=0
