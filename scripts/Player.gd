extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const CROUCH_SPEED = 3.0
const CROUCH_DEPTH = -0.5
const JUMP_VELOCITY = 3.5

const SENSITIVITY_MULTIPLIER = 0.001

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
@onready var raycast = $RayCast3D

@onready var crouchCollision = $crouchingCollisionShape
@onready var standCollision = $standingCollisionShape

@onready var camera = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	var sens = Global.sensitivity*SENSITIVITY_MULTIPLIER
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sens)
		camera.rotate_x(-event.relative.y * sens)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("crouch"):
		speed = CROUCH_SPEED
		head.position.y = 0.8 + CROUCH_DEPTH
		standCollision.disabled = true
		crouchCollision.disabled = false
	elif !raycast.is_colliding():
		standCollision.disabled = false
		crouchCollision.disabled = true
		head.position.y = 0.8
		if Input.is_action_pressed("sprint"):
			speed = SPRINT_SPEED
		else:
			speed = WALK_SPEED

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
		
	# head bob
#	t_bob += delta * velocity.length() * float(is_on_floor())
#	camera.transform.origin = _headbob(t_bob)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
