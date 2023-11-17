extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Maps/level1.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Main Menu/settings.tscn")

func _ready():
	var config = ConfigFile.new()
	config.set_value("Settings", "Fullscreen", true)
	config.set_value("Settings", "Volume", "0")
	
	config.save("res://config.cfg")
