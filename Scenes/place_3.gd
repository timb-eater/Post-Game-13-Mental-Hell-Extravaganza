extends Node3D

var amount_hit = 0

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_npc_interacted(body, id):
	$NPCs/Npc.global_position = $"npc fall".global_position


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		Global.goto_scene("res://Scenes/place_4.tscn", "door4")


func _on_chaser_box_body_entered(body):
	if body.name == "Player":
		body.rotate_x(90)
		amount_hit += 1
	if amount_hit >= 3:
		get_tree().change_scene_to_file("res://Scenes/cutscenes/cutscene2.tscn")
