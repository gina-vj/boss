extends Node2D

signal finished_impact()

onready var tween = $Tween
onready var body = $Body
onready var trail_particles: Particles2D = $Trail
onready var impact_particles: Particles2D = $Impact
onready var sfx: AudioStreamPlayer2D = $SFX
onready var water_explosion = $WaterExplosion

export (AudioStream) var impact_sound

func _ready():
	tween.interpolate_property(body, "rotation_degrees", 0, 360, 1)
	tween.start()
	trail_particles.visible = true
	
func impact():
	trail_particles.visible = false
	impact_particles.visible = true
	impact_particles.emitting = true
	body.visible = false
	sfx.stream = impact_sound
	sfx.play()
	water_explosion.initiate_explosion()
	yield(water_explosion, "exposion_finished")
	emit_signal("finished_impact")
