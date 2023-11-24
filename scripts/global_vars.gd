extends Node

var can_pause = true
var paused = false
var destination : Vector3

func goto_scene(path, coordinates:Vector3):
	destination = coordinates
