class_name Interactable
extends StaticBody3D

signal interacted(body)

@export var prompt_message = "Interact"
@export var prompt_action = "interact"
@export var destination_scene : String

func get_prompt():
	return prompt_message

func interact(body):
	emit_signal("interacted", body)
