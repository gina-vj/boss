extends CanvasLayer

signal pausa()

func _on_Button_pressed():
	_pausa()
	
func _on_Continuar_pressed():
	_pausa()

func _pausa():
	emit_signal("pausa")
	
func _on_Restart_pressed():
	PlayerData.restart(false)
