extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(_delta):
	self.value=PlayerData.current_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
