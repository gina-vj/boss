extends VBoxContainer

onready var count = $Count
onready var texture = $Texture
onready var tween_brightness: Tween = $TweenBrightness
onready var tween_contrast:Tween = $TweenContrast

const tween_duration:float = 0.5

func _ready():
	# Implement this. For example:
	# Bag.connect("player_found_experimental_vaccines", self, "animate_texture")
	pass


func animate_texture():
	tween_brightness.interpolate_property(texture.material, "shader_param/brightness", 0, 1, tween_duration)
	tween_brightness.connect("tween_all_completed", self, "brightness_completed")
	
	tween_contrast.interpolate_property(texture.material, "shader_param/contrast", 1, 3, tween_duration)
	tween_contrast.connect("tween_all_completed", self, "contrast_completed")

	tween_brightness.start()
	tween_contrast.start()

func brightness_completed():
	tween_brightness.disconnect("tween_all_completed", self, "brightness_completed")
	tween_brightness.interpolate_property(texture.material, "shader_param/brightness", 1, 0, tween_duration)
	tween_brightness.start()
	
func contrast_completed():
	tween_contrast.disconnect("tween_all_completed", self, "contrast_completed")
	tween_contrast.interpolate_property(texture.material, "shader_param/contrast", 3, 1, tween_duration)
	tween_contrast.start()
