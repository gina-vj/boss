extends Node2D

onready var collission_shape = $Area2D/CollisionShape2D
onready var sfx_player: AudioStreamPlayer2D = $SFX

enum ComponentsEnum {FIRST, SECOND, THIRD}
export(ComponentsEnum) var component

func _on_Area2D_body_entered(_body):
	if(component == ComponentsEnum.FIRST):
		PlayerData.first_component_found()
	elif(component == ComponentsEnum.SECOND):
		PlayerData.second_component_found()
	elif(component == ComponentsEnum.THIRD):
		PlayerData.third_component_found()
		
	collission_shape.set_deferred("disabled", true)
	visible = false
	sfx_player.play()
	yield(sfx_player, "finished")
	queue_free()
