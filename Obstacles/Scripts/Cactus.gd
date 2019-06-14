extends Area2D


var velocity=Vector2()
var speed=300

func _ready():
	randomize()
	var randScale=rand_range(0.8, 1)
	scale=Vector2(randScale, randScale)
	velocity=Vector2(-speed, 0)
	set_process(true)
	pass
	
	
func _process(delta):
	translate(velocity * delta)
	pass


func _on_Cactus_body_entered(body):
	if body.get_name() == "Player":
		body.kill()
	pass
