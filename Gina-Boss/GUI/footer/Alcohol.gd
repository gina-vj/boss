extends "./AbstractItem.gd"

func _ready():
	Bag.connect("player_found_alcohol", self, "animate_texture")

func _process(_delta):
	count.text = str(Bag.alcohol)
