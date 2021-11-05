extends Control

onready var config_menu = $MenuConfig
onready var config_video = $MenuConfig/MainMenu2/MainConfiguracion/ConfiguracionVideo
onready var config_audio = $MenuConfig/MainMenu2/MainConfiguracion/ConfiguracionAudio
onready var config_controles = $MenuConfig/MainMenu2/MainConfiguracion/ConfiguracionControles
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
