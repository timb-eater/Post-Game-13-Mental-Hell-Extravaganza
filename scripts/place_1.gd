extends Node3D

const place_2 = "res://Scenes/place_2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.destination:
		$Player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		$Player/Head.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_teleport_interacted(body):
	Global.goto_door(place_2, "door1")
