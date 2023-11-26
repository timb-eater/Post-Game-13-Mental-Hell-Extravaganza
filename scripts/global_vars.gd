extends Node

var save_file = "user://PostGamesave.json"

var can_pause = true
var paused = false
var destination : String
var destination_scene : String

var sensitivity : int = 5

###

var save_position : Vector3

var save_scene : String

var is_loading := false

func goto_door(scene, door):
	# Load the new scene
	get_tree().change_scene_to_file(scene)
	paused = false
	destination = door

func goto_scene(place, door):
	ResourceLoader.load_threaded_request(place)
	goto_door(place, door)

func save(save_position, scene):
	var save_dict = {
		
		"scene" : scene,
		"save_position" : save_position
		
	}
	return save_dict

func save_data(save_position, scene):
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	var json_string = JSON.stringify(save(save_position, scene))
	file.store_line(json_string)
	file.close()

func load_data():
	var file = FileAccess.open(save_file, FileAccess.READ)
	if not FileAccess.file_exists(save_file):
		return
	
	var parsedResult = JSON.parse_string(file.get_as_text())
	if parsedResult is Dictionary:
		return parsedResult
		file.close()
	else:
		print("error")

func load_game(scene):
	get_tree().change_scene_to_file(scene)
	is_loading = true

func str_to_Vector3(string):
	var position_vector = Vector3()
	var split_string = string.replace("(", "").replace(")", "").split(",")
	
	position_vector.x = float(split_string[0])
	position_vector.y = float(split_string[1])
	position_vector.z = float(split_string[2])
	
	return position_vector
