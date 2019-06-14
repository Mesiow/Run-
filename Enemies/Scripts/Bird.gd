extends Area2D

var velocity=Vector2()
var speed=0

onready var anim=get_node("AnimatedSprite")

func _ready():
	randomize()
	var randVelX=rand_range(150.0, 250.0)
	speed=randVelX
	velocity=Vector2(-speed, 0)
	anim.play("fly")
	
	set_process(true)
	pass
	
func _process(delta):
	translate(velocity * delta)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass

func _on_Bird_body_entered(body):
	if body.get_name() == "Player":
		body.emitPlayerLost()
	pass
