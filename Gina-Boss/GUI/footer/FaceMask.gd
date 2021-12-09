extends "./AbstractItem.gd"

func _ready():
	# warning-ignore:return_value_discarded
	Bag.connect("player_found_face_masks", self, "animate_texture")

func _process(_delta):
	count.text = str(Bag.face_masks)
