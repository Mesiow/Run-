extends Area2D

var velocity=Vector2(0,0)
var speed = 200

onready var environment= get_tree().get_root().get_node("/root/World/Environment")
var freePosition

func _ready():
	set_process(true)
	var ground = environment.get_node("Ground")
	freePosition = ground.global_position.y
	
	velocity.y = speed
	pass
	
func _process(delta):
	if global_position.y >= freePosition:
		queue_free()
	
	translate(velocity * delta)
	pass


func _on_Projectile_body_entered(body):
	if body.get_name() == "Player":
		body.kill()
	pass
