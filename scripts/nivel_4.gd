extends Control
var cantidad_tocado : int = 0


func comprobar_evento_click():
	if(cantidad_tocado > 3):
		$logo.freeze = false

func _on_logo_input_event(_viewport, event, _shape_idx):
	print("tocado")
	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		if event.pressed:
			print("tocado")
			cantidad_tocado +=1 
			comprobar_evento_click()

