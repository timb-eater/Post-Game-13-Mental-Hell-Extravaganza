extends Control

@onready var pause_menu = $pause_menu

func _ready():
	pause()

func _unhandled_input(event):
	if Input.is_action_just_pressed("pause") and Global.can_pause:
		pause()

func pause():
	if Global.paused:
		pause_menu.show()
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		pause_menu.hide()
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.paused = !Global.paused


func _on_quit_pressed():
	get_tree().quit()


func _on_resume_pressed():
	pause()
