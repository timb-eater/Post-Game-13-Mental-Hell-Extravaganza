extends CharacterBody3D
class_name NPC

@onready var animation_tree = $AnimationTree
@onready var audio = $Screams

@export var dialog_id : String

signal interacted(body, id)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	animation_tree.set("parameters/conditions/idle", velocity == Vector3.ZERO)
	animation_tree.set("parameters/conditions/walk", velocity != Vector3.ZERO)
	
	if !is_on_floor():
		velocity.y -= gravity * delta
		if audio:
			if !audio.playing:
				audio.play()
	elif is_on_floor():
		if audio:
			audio.playing = false
	
	move_and_slide()

func interact(body):
	emit_signal("interacted", body, dialog_id)
