extends Node2D

export var opened: bool = true

onready var lasers = $Lasers
onready var sfx:AudioStreamPlayer2D = $SFX

var locked = false
var first_doorstep_crossed = false

func _ready():
	lasers.toogle(opened)
	sfx.stop()

func open():
	lasers.toogle(true)
	sfx.stop()

func close():
	lasers.toogle(false)
	sfx.play()

func lock():
	locked = true

func unlock():
	locked = false

func toogle_door(_body):
	if !locked:
		if lasers.opened():
			sfx.play()
		else:
			sfx.stop()

		lasers.toogle(!lasers.opened())
