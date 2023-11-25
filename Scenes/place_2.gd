extends Node3D


const place_1 = "res://Scenes/place_1.tscn"
@onready var dialogue_box = $DialogueHandler/DialogueBox
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	position_player($Player, $Player/Head)
	$"Swinging Man/swinging man/AnimationPlayer".play()

func position_player(player, playerHead):
	if Global.destination:
		player.global_transform.origin = get_node(Global.destination + "/Marker3D").global_transform.origin
		playerHead.global_rotation = get_node(Global.destination + "/Marker3D").global_rotation


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
		$DialogueHandler/RichTextLabel.show()


func _on_door_2_interacted(body):
	get_tree().change_scene_to_file("res://Scenes/cutscenes/cutscene2.tscn")
