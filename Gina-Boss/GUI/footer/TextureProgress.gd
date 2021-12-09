extends TextureProgress
onready var timer=$Timer
onready var final_dash= $FinalDashBar


func _ready():
	max_value = 5

func _physics_process(delta):
	if PlayerData.current_stamina == max_value:
		final_dash.visible = true
	else:
		final_dash.visible = false

	value=PlayerData.current_stamina
	

