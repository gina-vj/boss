extends VBoxContainer

onready var count = $Count

func _process(_delta):
	count.text = str(Bag.face_masks)
