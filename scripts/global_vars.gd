extends Node

var save_path = "user://save.save"

var can_pause = true
var paused = false
var destination : String
var destination_scene : String

var sensitivity : int = 5

###

var save_position : Vector3

var save_scene : String

func goto_door(scene, door):
	# Load the new scene
	get_tree().change_scene_to_file(scene)
	paused = false
	destination = door

func goto_scene(place, door):
	ResourceLoader.load_threaded_request(place)
	goto_door(place, door)

func save_data(save_position, scene):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_line(str(scene))
	file.store_line(str(save_position))
	file.close()

func load_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if not FileAccess.file_exists(save_path):
		return
