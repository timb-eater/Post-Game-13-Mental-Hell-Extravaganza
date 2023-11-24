extends Node3D


const place_1 = "res://Scenes/place_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.destination:
		$Player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		$Player/Head.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_teleport_interacted(body):
	ResourceLoader.load_threaded_request(place_1)
	Global.goto_door(place_1, "door1")
