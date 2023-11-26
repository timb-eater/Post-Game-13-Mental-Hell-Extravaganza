extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$CanvasLayer/RichTextLabel.hide()
	Global.destination = ""
	


func _on_button_pressed():
	$CanvasLayer/RichTextLabel.show()
	$CanvasLayer/Button.hide()
	$AnimationPlayer.play("credits")
	$AudioStreamPlayer.play()


func _on_quit_pressed():
	get_tree().quit()
