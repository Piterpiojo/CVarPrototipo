extends Control

func cambiar_texto(texto):
	$ColorRect/Label.text=texto
func _ready():
	$AnimatedSprite2D.play("default")

func _on_button_pressed():
	$ColorRect.visible=true
	$Timer.start()



func _on_timer_timeout():
	$ColorRect.visible=false
