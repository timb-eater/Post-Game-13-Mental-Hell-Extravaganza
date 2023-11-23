extends Node

enum {
	IDLE,
	WANDER
}

@onready var start_position: Vector3
@onready var target_position: Vector3
@onready var npc = $".."

@export var radius: int = 32

var velocity = Vector2.ZERO
var state = IDLE

const ACCELERATION = 300
const MAX_SPEED = 50
const TOLERANCE = 4.0

func is_at_target_position(): 
	# Stop moving when at target +/- tolerance
	return (target_position - npc.position).length() < TOLERANCE


func update_target_position():
	var target_vector = Vector3(randf_range(-radius, radius), 0, randf_range(-radius, radius))
	target_position = start_position + target_vector

func _physics_process(delta):
	match state:
		IDLE:
			state = WANDER
			update_target_position()
		WANDER:
			if is_at_target_position():
				state = IDLE

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - npc.position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	velocity = velocity.clamped(MAX_SPEED)
