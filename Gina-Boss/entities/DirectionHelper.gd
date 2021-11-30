extends Node
class_name DirectionHelper

enum Directions { UP, DOWN, LEFT, RIGHT }

var current_direction
func _init():
	current_direction = Directions.DOWN

func looking_up():
	return current_direction == Directions.UP

func looking_down():
	return current_direction == Directions.DOWN

func looking_left():
	return current_direction == Directions.LEFT
	
func looking_right():
	return current_direction == Directions.RIGHT

func deduce_direction(direction):
	if direction == Vector2.ZERO:
		return current_direction

	var angle = rad2deg(direction.angle())
	if angle < 0:
		angle = 360 + angle

	if angle <= 45 or angle > 315:
		current_direction = Directions.RIGHT
	elif angle > 45 and angle <= 135:
		current_direction = Directions.DOWN
	elif angle > 135 and angle <= 225:
		current_direction = Directions.LEFT
	elif angle > 225 and angle <= 315:
		current_direction = Directions.UP	

