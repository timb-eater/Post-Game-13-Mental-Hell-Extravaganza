extends Node

var can_pause = true
var paused = false
var destination : String

func goto_door(scene, door):
	# Load the new scene
	get_tree().change_scene_to_file(scene)
	paused = false
	
	destination = door
