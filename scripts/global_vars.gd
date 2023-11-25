extends Node

var can_pause = true
var paused = false
var destination : String
var destination_scene : String

func goto_door(scene, door):
	# Load the new scene
	get_tree().change_scene_to_file(scene)
	paused = false
	destination = door

func position_player(player, playerHead, door):
	if destination:
		player.global_transform.origin = get_node(door + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(door + "/Marker3D").global_rotation
