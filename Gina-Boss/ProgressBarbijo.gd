extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	print(Bag.duration_barbijo)
	self.max_value=Bag.max_duration_barbijo
	self.value=Bag.duration_barbijo
	self.visible=Bag.duration_barbijo>0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
