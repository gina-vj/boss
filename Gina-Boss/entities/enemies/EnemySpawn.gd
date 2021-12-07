tool
extends Node

export (PackedScene) var element_scene:PackedScene setget set_element_scene
export (bool) var spawn_element:bool = false setget set_spawn_element

func set_element_scene(value:PackedScene):
	element_scene = value


func set_spawn_element(value:bool):
	spawn_element = false
	if value && Engine.editor_hint:
		_spawn_element(element_scene)


func _spawn_element(scene:PackedScene):
	var new_element = scene.instance()
	add_child(new_element)
	new_element.set_owner(get_tree().get_edited_scene_root())
