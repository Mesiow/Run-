extends Area2D

var velocity=Vector2(0,0)
var direction=Vector2(0,0)
var rotate = 0

onready var environment= get_tree().get_root().get_node("/root/World/Environment")
var queueFreePos

func _ready():
	randomize()
	var speed = rand_range(-150.0, -250.0)
	velocity = Vector2(speed, speed)
	
	var rot = rand_range(-0.1, 0.1)
	rotate = rot
	
	queueFreePos = environment.get_node("Ground").global_position.y
	set_process(true)
	pass
	
	
func setDir(dir):
	direction = dir
	pass
	
func _process(delta):
	if global_position.y >= queueFreePos:
		queue_free()
	
	rotate(rotate)
	translate(velocity * direction * delta)
	pass
