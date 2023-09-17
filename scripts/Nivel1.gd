extends Control
var dialogo = [
	"U: (frustrado) Tengo que dejar de posponer esto, ¡Vamos a ver si puedo crear una cuenta de una vez por todas!",
	"A: ¡Hola! Soy Ave, tu asistente virtual. Estoy aquí para facilitar la creación de tu cuenta ¿En qué puedo ayudarte hoy?",
	"U: (suspira) Necesito una cuenta, pero realmente es mi primera vez utilizando este programa. ¿Te molestaría enseñarme cómo seguir?",
	"A: ¡En lo absoluto, no hay problema! Mi trabajo es asistirte con lo que pueda ayudarte! (tras un breve silencio) Oh, parece que la página está caída.",
	"U: ¿En serio?",
	"A: No, fue un pequeño chiste. Bueno, para comenzar, tenemos que registrarte como un usuario en la página. Para eso, deberías entrar en el enlace que dice Si es un usuario nuevo presione aquí. Este botón te redirigirá al registro de usuario, que te permitirá crear la base de tu cuenta.",
	"A: blabla blabla blabla",
	"A: (divertido) blabla blabla blabla",
	"A: (serio) blabla blabla blabla",
	"A: blabla blabla blabla (pausa) blabla blabla blabla",
	"A: (amigable) blabla blabla blabla blabla",
	"A: ... y esa es la razón por la que se eligió ese tono de azul para la pantalla principal.",
	"U: (sarcásticamente) ¿En serio? Wow, jamás me lo hubiera esperado. ¿Podríamos continuar con la creación de la cuenta?",
	"A: (enérgicamente) Sí, definitivamente, ya mismo.",
	" ",
	"Realmente tienes suerte de tenerme contigo. Sin mi ayuda, podría haber resultado algo abrumador."
	]

func _ready():
	$CuadroDialogo.dialogos = dialogo
	$CuadroDialogo.comenzar()

func _on_nuevo_usuario_pressed():
	get_tree().change_scene_to_file("res://Escenas/Registro.tscn")
