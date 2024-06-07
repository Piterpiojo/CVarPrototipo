extends Area2D
var seleccionado : bool = false
var puedeSel :bool = true
@export var texto : String
var pos_inicial: Vector2

func _process(delta):
	if(seleccionado and puedeSel):
		_seguir_mouse(delta)


func _ready():
	$Label.text = texto
	pos_inicial=self.global_position

func _seguir_mouse(_delta):
	global_transform.origin = get_global_mouse_position()



func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			seleccionado = true

	if event is InputEventMouseButton :
		if !event.pressed:
			seleccionado = false
