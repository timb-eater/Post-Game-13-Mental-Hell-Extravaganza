extends State
class_name EnemyFollow

@export var enemy: CharacterBody3D
@export var move_speed := 10
@onready var player = $"../../../../Player"
@export var threshold := 100
@export var chase_sound : AudioStreamPlayer3D

signal reached_player(body)

func Enter():
	pass
func Physics_Update(delta: float):
	var direction = enemy.position.direction_to(player.global_position)
	var distance_from_player = enemy.position.distance_to(player.global_position)

	if distance_from_player < threshold:
		if !chase_sound.playing:
			chase_sound.play()
		enemy.velocity.x = direction.x * move_speed
		enemy.velocity.z = direction.z * move_speed
		var target_direction = enemy.global_transform.origin + enemy.velocity.normalized()
		enemy.look_at(target_direction, Vector3.UP)
	else:
		chase_sound.playing = false
		enemy.velocity.x = 0
		enemy.velocity.z = 0
	
	if direction.length() > 5:
		emit_signal("reached_player", enemy)
