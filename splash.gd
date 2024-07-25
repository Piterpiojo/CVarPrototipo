extends Control

func _ready():
	$AnimationPlayer.play("splash")

func ir_al_menu():
	get_tree().change_scene_to_file("res://Escenas/menuFinal.tscn")
