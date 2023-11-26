extends Node3D

var jump_count = 0

func _ready():
	position_player($Player, $Player/Head)
	print($Player.global_position)
	$NPCs/Perkel.hide()

func position_player(player, playerHead):
	if Global.destination:
		player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation
	if Global.is_loading:
		player.global_transform.origin = Global.str_to_Vector3(Global.load_data().save_position)
		Global.is_loading = false


func _on_dialogue_box_dialogue_signal(value):
	if value == "sunny":
		$"NPCs/Mnlц".global_transform = $"NPCs/Mnlц/Jump".global_transform
		$Player/Head.look_at($"NPCs/Mnlц".global_transform.origin)
	if value == "look1":
		$NPCs/Perkel.show()
		$Player/Head.look_at($NPCs/Perkel.global_transform.origin)
	if value == "look2":
		$Player/Head.look_at($NPCs/Snem.global_transform.origin)

func _on_area_3d_body_entered(body):
	print("entered")
	body.global_position = Vector3(body.global_position.x, 100, body.global_position.z)
	if body.name == "Player":
		jump_count += 1
	if jump_count >= 10:
		get_tree().change_scene_to_file("res://Scenes/cutscenes/credits.tscn")


func _on_area_3d_2_body_entered(body):
	body.global_position = $Area3D2/Marker3D.global_position
