extends Node2D

signal exposion_finished()

export (int) var disinfection_duration : int = 4

onready var sound : AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var area : Area2D = $Area2D

func _ready():
	area.set_deferred("monitorable", false)
	area.set_deferred("monitoring", false)

func initiate_explosion():
	area.set_deferred("monitorable", true)
	area.set_deferred("monitoring", true)
	animated_sprite.play("explosion")
	sound.play(0.1)

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.desinfect_area(disinfection_duration)


func _on_AudioStreamPlayer2D_finished():
	if !animated_sprite.is_playing():
		emit_signal("exposion_finished")


func _on_AnimatedSprite_animation_finished():
	area.monitorable = false
	area.monitoring = false
	if sound.is_playing():
		emit_signal("exposion_finished")
