extends Control

@onready var pause_menu = $pause_menu

func _ready():
	$pause_menu/Options/Sensitivity.text = "sensitivity: " + str(Global.sensitivity)
	$pause_menu/Options/HSlider.value = Global.sensitivity
	$pause_menu.hide()

func _unhandled_input(event):
	if Input.is_action_just_pressed("pause") and Global.can_pause:
		pause()

func pause():
	Global.paused = !Global.paused
	if Global.paused:
		pause_menu.show()
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		pause_menu.hide()
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_quit_pressed():
	get_tree().quit()


func _on_resume_pressed():
	pause()


func _on_h_slider_value_changed(value):
	$pause_menu/Options/Sensitivity.text = "sensitivity: " + str(Global.sensitivity)
	Global.sensitivity = value


func _on_save_pressed():
	Global.save_data($"../../..".global_position, get_tree().current_scene.scene_file_path)
