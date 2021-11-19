extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	if(Bag.has_throwable_items()):
		$Sprite.visible = true
		$Sprite.position = get_global_mouse_position()
	else:
		$Sprite.visible = false
