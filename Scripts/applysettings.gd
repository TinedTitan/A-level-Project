extends Button

var Fullscreen
var LabelVis
var config

func _process(delta):
	Fullscreen = get_node("/root/Control/FSChecker").button_pressed
	LabelVis = get_node("/root/Control/Label")
	config = ("res://config.cfg")

func _on_pressed():
	LabelVis.show()
	
	if Fullscreen == true:
		ProjectSettings.set_setting("display/window/size/mode", "Fullscreen" )
		print(ProjectSettings.get_setting("display/window/size/mode"))
		config.set_value("Settings", "Fullscreen", true)
	else:
		ProjectSettings.set_setting("display/window/size/mode", "Windowed" )
		print(ProjectSettings.get_setting("display/window/size/mode"))
		config.set_value("Settings", "Fullscreen", false)
		
	ProjectSettings.save()
	
