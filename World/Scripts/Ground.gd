extends StaticBody2D

var velocity=Vector2()
var speed=300

func _ready():
	velocity=Vector2(-speed, 0)
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	if global_position.x <= 0 - get_viewport_rect().size.x:
		global_position.x = 1730 #loop back around
	
	translate(velocity * delta)
	pass
	