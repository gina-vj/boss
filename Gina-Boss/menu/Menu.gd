extends Control

onready var config_menu = $MenuConfig
onready var config_video = $MenuConfig/MainMenuOptions/OptionConfigurations/VideoConfigurations
onready var config_audio = $MenuConfig/MainMenuOptions/OptionConfigurations/AudioConfigurations
onready var config_controles = $MenuConfig/MainMenuOptions/OptionConfigurations/KeymapConfigurations
onready var inicio = $MainMenu/Inicio

func _ready():
	inicio.grab_focus()

func _on_Inicio_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_Configuracion_pressed():
	config_menu.popup_centered()
	hide_settings()
	config_video.show()


func _on_Salir_pressed():
	get_tree().quit()


func _on_Video_pressed():
	hide_settings()
	config_video.show()


func _on_Audio_pressed():
	hide_settings()
	config_audio.show()


func _on_Controles_pressed():
	hide_settings()
	config_controles.show()
	
	
func hide_settings():
	config_video.hide()
	config_audio.hide()
	config_controles.hide()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_CheckButton_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)
