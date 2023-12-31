extends RayCast3D

@onready var label = $Label

signal interact

func _ready():
	add_exception(owner)

func _physics_process(delta):
	label.text = ""
	if is_colliding():
		var collider = get_collider()
		if collider is NPC:
			label.text = collider.name 
			if Input.is_action_just_pressed("interact"):
				collider.interact(owner)
		if collider is Interactable:
			label.text = collider.prompt_message
			if Input.is_action_just_pressed("interact"):
				collider.interact(owner)
