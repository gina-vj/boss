extends VBoxContainer

onready var component_one_empty = $ComponentOneEmpty
onready var component_one = $ComponentOne
onready var component_two_empty = $ComponentTwoEmpty
onready var component_two = $ComponentTwo
onready var component_three_empty = $ComponentThreeEmpty
onready var component_three = $ComponentThree

func _ready():
	component_one_empty.visible = true
	component_one.visible = false
	component_two_empty.visible = true
	component_two.visible = false
	component_three_empty.visible = true
	component_three.visible = false
	
	PlayerData.connect("first_component_found", self, "on_first_component_found")
	PlayerData.connect("second_component_found", self, "on_second_component_found")
	PlayerData.connect("third_component_found", self, "on_third_component_found")

func on_first_component_found():
	component_one_empty.visible = false
	component_one.visible = true
	
func on_second_component_found():
	component_two_empty.visible = false
	component_two.visible = true
	
func on_third_component_found():
	component_three_empty.visible = false
	component_three.visible = true


