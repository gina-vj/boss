extends BasicEnemy

export (int) var base_hits_needed

var current_hits_taked : int = 0

onready var detection_sound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func notify_hit(projectile):
	current_hits_taked += 1
	if current_hits_taked == base_hits_needed:
		.notify_hit(projectile)
		
func _on_DisinfectionTimer_timeout():
	current_hits_taked = 0
	._on_DisinfectionTimer_timeout()
	
func _on_DetectionArea_body_entered(_body):
	detection_sound.play()
	state_machine.notify_body_entered(_body)
