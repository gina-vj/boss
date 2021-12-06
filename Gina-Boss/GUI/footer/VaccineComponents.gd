extends TextureRect

onready var tween_brightness: Tween = $TweenBrightness

const tween_duration = 1.0

export(Texture) var all_empty:Texture
export(Texture) var with_red:Texture
export(Texture) var with_red_and_green:Texture
export(Texture) var with_red_green_and_blue:Texture

signal animation_finished()

func _ready():
	texture = all_empty
	
	PlayerData.connect("first_component_found", self, "on_first_component_found")
	PlayerData.connect("second_component_found", self, "on_second_component_found")
	PlayerData.connect("third_component_found", self, "on_third_component_found")

func on_first_component_found():
	animate_texture()
	yield(self, "animation_finished")
	texture = with_red
	
func on_second_component_found():
	animate_texture()
	yield(self, "animation_finished")
	texture = with_red_and_green
	
func on_third_component_found():
	animate_texture()
	yield(self, "animation_finished")
	texture = with_red_green_and_blue


func animate_texture():
	tween_brightness.interpolate_property(material, "shader_param/brightness", 0, 1, tween_duration)
	tween_brightness.connect("tween_all_completed", self, "brightness_completed")
	tween_brightness.start()

func brightness_completed():
	emit_signal("animation_finished")
	tween_brightness.disconnect("tween_all_completed", self, "brightness_completed")
	tween_brightness.interpolate_property(material, "shader_param/brightness", 1, 0, tween_duration)
	tween_brightness.start()


