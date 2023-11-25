extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	position_player($Player, $Player/Head)

func position_player(player, playerHead):
	if Global.destination:
		player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_npc_interacted(body, id):
	$NPCs/Npc.global_position = $"npc fall".global_position


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		body.global_position = $door3/Marker3D.global_position


func _on_chaser_box_body_entered(body):
	if body.name == "Player":
		body.rotate_x(90)
