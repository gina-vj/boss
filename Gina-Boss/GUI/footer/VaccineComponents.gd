extends TextureRect
export(Texture) var all_empty:Texture
export(Texture) var with_red:Texture
export(Texture) var with_red_and_green:Texture
export(Texture) var with_red_green_and_blue:Texture

func _ready():
	texture = all_empty
	
	PlayerData.connect("first_component_found", self, "on_first_component_found")
	PlayerData.connect("second_component_found", self, "on_second_component_found")
	PlayerData.connect("third_component_found", self, "on_third_component_found")

func on_first_component_found():
	texture = with_red
	
func on_second_component_found():
	texture = with_red_and_green
	
func on_third_component_found():
	texture = with_red_green_and_blue


