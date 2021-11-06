extends Node2D

class_name ProyectileAlcohol
onready var hitbox = $Hitbox
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var heal_points
var direction:Vector2
export (float) var VELOCITY:float = 300.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func initialize(container, spawn_position:Vector2, direction:Vector2):
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	self.heal_points = 1

func _physics_process(delta:float):
	position += direction * VELOCITY * delta


func _on_Hitbox_body_entered(body):
	if body.has_method("notify_hit"):
		body.notify_hit(self)
	hitbox.collision_layer = 0
	hitbox.collision_mask = 0

	call_deferred("_remove")
