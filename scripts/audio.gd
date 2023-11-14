extends AudioStreamPlayer
var dialogos = preload("res://sonidos/Musica y sonidos a utilizar/Drumming Sticks.ogg")
var gameplay = preload("res://sonidos/Musica y sonidos a utilizar/Infinite Descent.ogg")

func _ready():
	stream = dialogos
	play()


func gameplay_play():
	stream = gameplay
	play()
