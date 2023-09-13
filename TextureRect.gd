extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_v_scroll_bar_scrolling():
	pass # Replace with function body.


func _on_v_scroll_bar_value_changed(value):
	position.y = -value
