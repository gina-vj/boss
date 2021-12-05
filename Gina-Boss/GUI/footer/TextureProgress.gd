extends TextureProgress
onready var timer=$Timer
onready var final_dash= $FinalDashBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _initialize():
	timer.stop()
	value=100
func _physics_process(delta):
	if value==100:
		final_dash.visible=true
	else:
		final_dash.visible=false
		
func _buy_dash():
	for i in range(100):
		timer.start(0.0001)



func _on_Timer_timeout():
	value-=1
	

