extends Node2D

signal finished_impact()

onready var body = $Body
onready var trail_particles: Particles2D = $Trail
onready var impact_particles: Particles2D = $Impact
onready var sfx: AudioStreamPlayer2D = $SFX

export (AudioStream) var impact_sound

func _ready():
	trail_particles.visible = true
	
func impact():
	trail_particles.visible = false
	impact_particles.visible = true
	impact_particles.emitting = true
	body.visible = false
	sfx.stream = impact_sound
	sfx.play()
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("finished_impact")
