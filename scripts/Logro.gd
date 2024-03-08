extends ColorRect

func fijar_logro(titulo, descripcion):
	$Titulo.text = titulo
	$Descripcion.text = descripcion
	$AnimationPlayer.play("Logro_Desbloquead")

