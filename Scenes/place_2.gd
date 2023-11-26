extends Node3D


const place_1 = "res://Scenes/place_1.tscn"
const place_3 = "res://Scenes/place_3.tscn"
@onready var dialogue_box = $DialogueHandler/DialogueBox
@onready var manball_text = $DialogueHandler/RichTextLabel
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	position_player($Player, $Player/Head)
	$"Swinging Man/swinging man/AnimationPlayer".playback_active = true
	print($Player.global_position)

func position_player(player, playerHead):
	if Global.destination:
		player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation
	if Global.is_loading:
		player.global_transform.origin = Global.str_to_Vector3(Global.load_data().save_position)
		Global.is_loading = false

func _on_teleport_interacted(body):
	ResourceLoader.load_threaded_request(place_1)
	Global.goto_door(place_1, "door1")


func _on_interactable_interacted(body):
	dialogue_box.start_id = "2"
	if !dialogue_box.running:
		dialogue_box.start()
	Global.can_pause = false
	body.set_physics_process(false)
	body.set_process_input(false)
	player = body


func _on_tv_interacted(body):
	pass #later make player go some other fucking place


func _on_area_3d_body_entered(body):
	body.global_transform.origin = $door1/Marker3D.global_transform.origin
	$AudioStreamPlayer.play()
	if body.name == "Manball":
		manball_text.show()
		manball_text.append_text("you threw the manball into the well......
regret yourself? ms")


func _on_door_2_interacted(body):
	get_tree().change_scene_to_file("res://Scenes/cutscenes/cutscene2.tscn")


func _on_door_3_interacted(body):
	ResourceLoader.load_threaded_request(place_3)
	Global.goto_door(place_3, "door3")


func _on_dialogue_box_dialogue_signal(value):
	if value == "place_4":
		Global.goto_door("res://Scenes/place_4.tscn", "door4")
