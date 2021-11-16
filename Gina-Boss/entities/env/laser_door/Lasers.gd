extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var collission_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	animation_player.play("blink")

func opened():
	return !visible

func toogle(opened):
	collission_shape.set_deferred("disabled", opened)
	visible = !opened

