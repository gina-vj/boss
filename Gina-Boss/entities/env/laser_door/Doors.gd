extends Node

onready var first_component_door = $LaserDoorFirstComponent
onready var second_component_door = $LaserDoorSecondComponent
onready var third_component_door = $LaserDoorThirdComponent
onready var boss_door = $LaserDoorBoss

func _ready():
	PlayerData.connect("first_component_found", self, "first_component_found")
	PlayerData.connect("second_component_found", self, "second_component_found")
	PlayerData.connect("third_component_found", self, "third_component_found")
	
	first_component_door.open()
	first_component_door.unlock()

	second_component_door.close()
	second_component_door.lock()

	third_component_door.close()
	third_component_door.lock()

	boss_door.close()
	boss_door.lock()
	

func first_component_found():
	second_component_door.open()
	second_component_door.lock()
	
func second_component_found():
	second_component_door.close()
	second_component_door.unlock()

	third_component_door.open()
	third_component_door.lock()

func third_component_found():
	third_component_door.close()
	third_component_door.unlock()
	
	boss_door.open()
