extends Node2D
	
func _process(delta):
	if(Bag.has_throwable_items()):
		$Sprite.position = get_global_mouse_position()
		$Sprite.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		$Sprite.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
