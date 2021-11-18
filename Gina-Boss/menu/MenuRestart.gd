extends MenuButton

#TODO: no se donde se usa esto
func _on_Continuar_pressed():
	self.visible=false
	get_tree().paused=false
	

func _on_Restart_pressed():
	self.visible=false
	get_tree().reload_current_scene()
