extends Control
var cantidad_tocado : int = 0
var fuerza : Vector2 
var ya_cayo =false
var poder= 8000
var contador_entrada = 0
var bandera1= false
var bandera2 = false
const sondioExito= preload("res://sonidos/Musica y sonidos a utilizar/confirmation_004.ogg")
var posInicial
var progreso = 0

func _ready():
	randomize()
	$CuadroDialogo.dialogos= CargaArchivos.cargar("nivel4")
	$CuadroDialogo.comenzar()
	posInicial= $logo.global_position
	guardar_avances()


func guardar_avances():
	CargaArchivos.guardar_avance(4, $CuadroDialogo.indice_dialogo)
	CargaArchivos.establecer_progreso(4,progreso)

func _process(_delta):
	if($CuadroDialogo.indice_dialogo == 9 and !bandera1):
		$CuadroDialogo.desactivar_dialogo()
		$CuadroDialogo.letra=0
		$boton/Area2D/CollisionShape2D.disabled = false
		$ayuda.cambiar_texto("Presiona el boton")
		progreso = 33
		bandera1= true
	elif ($CuadroDialogo.indice_dialogo == 13 and !bandera2):
		$CuadroDialogo.desactivar_dialogo()
		$CuadroDialogo.letra=0
		$ayuda.cambiar_texto("Atrapa ese boton, quizas podrias aplastarlo con algo...")
		bandera2 = true
		progreso = 66


func mod_fuerza():
	fuerza.x = randf_range(-poder,poder)
	fuerza.y = randf_range(-poder,poder)
	
func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused=true
		$Pausa.visible=true

	
func comprobar_evento_click():
	if(cantidad_tocado > 2):
		ya_cayo = true
		$logo.freeze = false
		$AudioStreamPlayer.play()

		



func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT ):
		if event.pressed:
			cantidad_tocado +=1 
			$AnimationPlayer.play("sacudir")
			comprobar_evento_click()


func _on_area_2d_mouse_entered():
		contador_entrada +=1
		mod_fuerza()
		$boton.apply_force(fuerza, self.global_position)
		if(contador_entrada == 3):
			$CuadroDialogo.habilitar_dialogo()
			$CuadroDialogo.sig_dialogo()
			$CuadroDialogo.letra=0


func _on_area_2d_body_entered(body):
	if body.name == "boton" and ya_cayo:
		poder = 1000
		body.get_child(1).disabled = false
		$CuadroDialogo.habilitar_dialogo()
		$CuadroDialogo.sig_dialogo()
		$CuadroDialogo.letra=0
		$AudioStreamPlayer.stream= sondioExito
		$AudioStreamPlayer.play()
		ya_cayo=true

func cambiar_escena():
	get_tree().change_scene_to_file("res://Escenas/nivel5/nivel5.tscn")

func _on_boton_pressed():
	progreso = 100
	guardar_avances()
	$AnimationPlayer.play("fin")
	
func reset():
	$logo.global_position=posInicial
	ya_cayo=false
	$logo.freeze=true
 
func _on_button_pressed():
	reset()
