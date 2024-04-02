extends Control


func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		volver()

func _on_menu_pressed():
	get_tree().paused=false
	get_parent().guardar_avances()
	get_tree().change_scene_to_file("res://Escenas/menuFinal.tscn")
	

func volver():
	get_tree().paused=false
	self.visible=false
	
func _on_volver_pressed():
	volver()
