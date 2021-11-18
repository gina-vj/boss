extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$MenuButton.visible=true
	get_tree().paused=true


func _on_Continuar_pressed():
	$MenuButton.visible=false
	get_tree().paused=false


func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://screens/Menu.tscn")
