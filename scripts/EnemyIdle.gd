extends State
class_name EnemyIdle

@export var enemy: CharacterBody3D
@export var move_speed := 3

var move_direction : Vector3
var wander_time : float
var wait_time : float

var talking = false

func randomize_wander():
	move_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	wait_time = randf_range(1, 3)
	
func Enter():
	randomize_wander()

func Update(delta: float):
	if wander_time >= 0:
		wander_time -= delta
	else: 
		if wait_time >= 0 or talking == true:
			wait_time -= delta
			enemy.velocity.x = 0
			enemy.velocity.z = 0
		else:
			randomize_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity.x = move_direction.x * move_speed
		enemy.velocity.z = move_direction.z * move_speed
		var target_direction = enemy.global_transform.origin + enemy.velocity.normalized()
		enemy.look_at(target_direction, Vector3.UP)
