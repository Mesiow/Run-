extends Area2D

var velocity=Vector2(0,0)
var speed = 200

onready var environment= get_tree().get_root().get_node("/root/World/Environment")
var queueFreePos

func _ready():
	var ground = environment.get_node("Ground")
	queueFreePos = ground.global_position.y
	
	velocity.y = speed
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	if global_position.y >= queueFreePos:
		queue_free()
	
	translate(velocity * delta)
	pass


func _on_Projectile_body_entered(body):
	if body.get_name() == "Player":
		body.kill()
	pass
