extends Node3D

@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("intro")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Scenes/place_1.tscn")

func _unhandled_key_input(event)			:
	if event:
		get_tree().change_scene_to_file("res://Scenes/place_1.tscn")
