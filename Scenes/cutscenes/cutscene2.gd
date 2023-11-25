extends Node3D

@onready var place_1 = "res://Scenes/place_1.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spin")
	$Timer.start()


func _on_timer_timeout():
	ResourceLoader.load_threaded_request(place_1)
	Global.goto_door(place_1, "door2")
