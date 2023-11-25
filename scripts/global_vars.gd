extends Node

var can_pause = true
var paused = false
var destination : String
var destination_scene : String

var sensitivity : int = 5

func goto_door(scene, door):
	# Load the new scene
	get_tree().change_scene_to_file(scene)
	paused = false
	destination = door

func goto_scene(place, door):
	ResourceLoader.load_threaded_request(place)
	goto_door(place, door)
