extends CanvasLayer

var player = null
@onready var dialogue_box = $DialogueBox
@onready var parent = get_node("..")
@onready var npcs = parent.get_node("NPCs").get_children()

func _ready():
	# Get the parent node
	
	# Get all NPC nodes
	
	for npc in npcs:
		npc.connect("interacted", Callable(self, "_on_npc_interacted"))

func _on_npc_interacted(body, id):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for npc in npcs:
		npc.set_physics_process(false)
	dialogue_box.start_id = id
	if !dialogue_box.running:
		dialogue_box.start()
	body.set_physics_process(false)
	body.set_process_input(false)
	player = body

func _on_dialogue_box_dialogue_ended():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	for npc in npcs:
		npc.set_physics_process(true)
	player.set_physics_process(true)
	player.set_process_input(true)
	player = null
