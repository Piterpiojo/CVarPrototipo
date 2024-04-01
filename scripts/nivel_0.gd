extends Control
var banderas=[false,false,false,false,false]

# Called when the node enters the scene tree for the first time.
func _ready():
	$CuadroDialogo.dialogos=CargaArchivos.cargar("nivel0")
	$CuadroDialogo.comenzar()
	$AnimationPlayer.play("al_centro")
	

func logro(titulo, descripcion):
	$Logro.fijar_logro(titulo,descripcion)

func _process(delta):
	if($CuadroDialogo.indice_dialogo == 1 and !banderas[0]):
		banderas[0]=true
		$AnimationPlayer.play("a_izq")
	elif($CuadroDialogo.indice_dialogo == 2 and !banderas[1]):
		banderas[1]=true
		$AnimationPlayer.play("a_der")
	elif($CuadroDialogo.indice_dialogo == 3 and !banderas[2]):
		banderas[2]=true
		$AnimationPlayer.play("RESET")
	elif($CuadroDialogo.indice_dialogo==43 and !banderas[3]):
		banderas[3]=true
		$ColorRect2.visible = true


func _on_color_rect_2_mouse_entered():
	$ColorRect2.visible = false
	$CuadroDialogo.sig_dialogo()
