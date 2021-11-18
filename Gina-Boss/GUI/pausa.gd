extends CanvasLayer

func _on_Button_pressed():
	$MenuButton.visible=true
	get_tree().paused=true

func _on_Continuar_pressed():
	$MenuButton.visible=false
	get_tree().paused=false

func _on_Restart_pressed():
	PlayerData.restart()
