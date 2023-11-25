extends Node3D

const place_2 = "res://Scenes/place_2.tscn"
@onready var dialogue_box = $DialogueHandler/DialogueBox
# Called when the node enters the scene tree for the first time.
func _ready():
	position_player($Player, $Player/Head)

func position_player(player, playerHead):
	if Global.destination:
		player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation


func _on_teleport_interacted(body):
	Global.goto_door(place_2, "door1")


func _on_door_2_interacted():
	dialogue_box.start_id = 6
	if !dialogue_box.running:
		dialogue_box.start()
