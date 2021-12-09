extends Node2D

class_name Item

export var item_quantity = 0
export(int, "Alcohol", "Experimental Vaccine", "Face Mask", "Suit") var item_type_index = 0

onready var item_quantity_node = $ItemQuantityBackground/ItemQuantity
onready var item_quantity_background = $ItemQuantityBackground
onready var sfx: AudioStreamPlayer2D = $SFX
onready var collision = $DetectionArea/CollisionShape2D
onready var pickup_label:Label = $Pickup/PickupLabel
onready var pickup_tween: Tween = $Pickup/PickupTween
onready var font = preload("res://entities/item/Item.tres")
onready var body = $Body

var type = null
var font_size = 10

func _ready():
	font.size = font_size
	type = index_to_type()
	item_quantity_node.text = str(item_quantity)
	pickup_label.text = str(item_quantity)
	pickup_label.visible = false

func index_to_type():
	return [
		Alcohol.type,
		ExperimentalVaccine.type,
		FaceMask.type,
		Suit.type
	][item_type_index]

func play_pickup_animation():
	pickup_label.visible = true
# warning-ignore:return_value_discarded
	pickup_tween.interpolate_property(font, "size", font_size, 300, 1)
# warning-ignore:return_value_discarded
	pickup_tween.start()
	yield(pickup_tween, "tween_all_completed")

func _on_DetectionArea_body_entered(_body):
	body.visible = false
	item_quantity_background.visible = false
	collision.set_deferred("disabled", true)
	Bag.add_item(type, item_quantity)
	sfx.play()
	play_pickup_animation()
	
	yield(sfx, "finished")
	queue_free()
