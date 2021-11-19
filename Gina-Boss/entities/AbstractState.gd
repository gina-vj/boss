"""
Base interface for all states: it doesn't do anything in itself
but forces us to pass the right arguments to the methods below
and makes sure every State object had all of these methods.
"""
extends Node

var parent: Node


signal finished(next_state_name)

# Initialize the state. E.g. change the animation
func enter():
	return

# Clean up the state. Reinitialize values like a timer
func exit():
	return


func handle_input(_event:InputEvent):
	return


func update(_delta:float):
	return


func _on_animation_finished(_anim_name:String):
	return