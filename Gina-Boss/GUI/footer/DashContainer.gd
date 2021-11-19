extends NinePatchRect

onready var dash = $Dash
onready var shift = $Shift
onready var shift_animation = $Shift/ShiftAnimation

func _ready():
	PlayerData.connect("dash_available", self, "shift_available")
	PlayerData.connect("dash_unavailable", self, "shift_unavailable")
	shift_available()

func shift_available():
	dash.frame = 1
	shift_animation.play("beat")

func shift_unavailable():
	dash.frame = 2
	shift_animation.play("fade_out")

