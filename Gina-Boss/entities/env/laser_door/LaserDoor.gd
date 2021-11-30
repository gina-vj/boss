extends Node2D

export var opened: bool = true

onready var lasers = $Lasers

var locked = false
var first_doorstep_crossed = false

func _ready():
	lasers.toogle(opened)

func open():
	lasers.toogle(true)

func close():
	lasers.toogle(false)

func lock():
	locked = true

func unlock():
	locked = false

func toogle_door(_body):
	if !locked:
		lasers.toogle(!lasers.opened())
