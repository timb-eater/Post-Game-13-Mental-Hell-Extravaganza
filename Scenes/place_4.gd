extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	position_player($Player, $Player/Head)

func position_player(player, playerHead):
	if Global.destination:
		player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation
	if Global.is_loading:
		player.global_transform.origin = Global.str_to_Vector3(Global.load_data().save_position)
		Global.is_loading = false

func _on_dialogue_box_dialogue_signal(value):
	if value == "smonche":
		get_tree().change_scene_to_file("res://Scenes/cutscenes/cutscene3.tscn")
	if value == "toilet":
		get_tree().change_scene_to_file("res://Scenes/cutscenes/cutscene2.tscn")
	if value == "diabolic_laugh":
		$NPCs/Smorg/laugh.play()
func _on_area_3d_body_entered(body):
	body.global_position = $Area3D/fall.global_position
	


func _on_mechul_interacted(body):
	Global.goto_door("res://Scenes/place_1.tscn", "door1")


func _on_doorp_interacted(body):
	Global.goto_door("res://Scenes/place_5.tscn", "doorp")
