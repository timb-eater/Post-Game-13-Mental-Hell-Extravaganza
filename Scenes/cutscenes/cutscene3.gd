extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("cuts")


func _on_animation_player_animation_finished(anim_name):
	if anim_name:
		Global.goto_door("res://Scenes/place_2.tscn", "door9")
