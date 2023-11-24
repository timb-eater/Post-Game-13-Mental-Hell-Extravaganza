extends CharacterBody3D
class_name NPC

@onready var animation_tree = $AnimationTree
@onready var audio = $Screams

@export var dialog : DialogueData

signal interacted(body)

var talking = false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	animation_tree.set("parameters/conditions/idle", velocity == Vector3.ZERO)
	animation_tree.set("parameters/conditions/walk", velocity != Vector3.ZERO)
	
	if !is_on_floor():
		velocity.y -= gravity * delta
		if !audio.playing:
			audio.play()
	elif is_on_floor():
		audio.playing = false
	
	move_and_slide()

func interact(body):
	emit_signal("interacted", body)
	
