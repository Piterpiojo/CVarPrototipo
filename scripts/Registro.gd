extends Control
var dialogo = [
	"A: (entusiasmada) Ahora que la página está de vuelta, ¡vamos a crear tu cuenta! Solo necesitamos llenar algunos datos personales primero",
	"...",
	"A: ¿Eso? Ni siquiera te preocupes, yo me encargo de eso en un parpadeo.",
	"",
	"A: ¿Te parece bien esto? Son solo algunos datos personales que necesitamos para continuar. Ten cuidado al seleccionar país de emisión, solo deberías tocar la opción de País de Emisión si seleccionamos Pasaporte."
]
var cuadros_llenos : int = 0
var ya_ejecuto : bool = false
var respuesta_secreta
func _ready():
	$CuadroDialogo.dialogos = dialogo
	$CuadroDialogo.comenzar()

func eliminar_fake():
	$ScrollContainer/TextureRect/fake.queue_free()
	



func _process(delta):
	if(!ya_ejecuto):
		_ejecutar_evento()
	
func aumentar_cuadro():
	cuadros_llenos+=1
	print("kusto")

func _ejecutar_evento():
	if $CuadroDialogo.dialogo_actual() == 3:
		$CuadroDialogo.habilitado = false
		$AnimationPlayer.play("arreglar")
		ya_ejecuto = true
		
func cambiar_dialogo():
	$CuadroDialogo.sig_dialogo()
	$CuadroDialogo.habilitado=true




func _on_nombre_text_submitted(new_text):
	aumentar_cuadro()


func _on_pasaporte_pressed():
	if $ScrollContainer/TextureRect/cuilBox.button_pressed == true:
		$CuadroDialogo.mostrar_dialogo_unico("solo deberías tocar la opción de País de Emisión si seleccionamos Pasaporte.")


func _on_respuesta_secreta_text_submitted(new_text):
	respuesta_secreta = new_text


func _on_respuesta_secreta_nuevamente_text_submitted(new_text):
	if respuesta_secreta == new_text:
		print("coincide")
	else:
		print("error")
		$CuadroDialogo.mostrar_dialogo_unico("No coinciden, no es que te este espiando, pero se nota que no coincide")
