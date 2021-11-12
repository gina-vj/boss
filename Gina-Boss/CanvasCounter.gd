extends CanvasLayer

onready var sectorItemsVacuna=$SectorItemsVacuna
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var itemNode=get_tree().get_root().find_node("ActionableItem",true,false)
	itemNode.connect("add_item","agregar")

func addPanel(item):
	sectorItemsVacuna.add_child()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func agregar():
	print("agregado")
