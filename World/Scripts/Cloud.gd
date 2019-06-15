extends Sprite

var velocity=Vector2()

onready var rain=$Rain

enum type{ REGULAR, RAIN }

func _ready():
	randomize()
	var randVelX=rand_range(100.0, 250.0)
	velocity=Vector2(-randVelX, 0)
	
	var randScale=rand_range(0.5, 1.0)
	scale=Vector2(randScale, randScale)
	
	determineType()
	set_physics_process(true)
	pass
	
func determineType():
	randomize()
	var random=randi() %2 + 0
	
	match random:
		type.REGULAR:rain.emitting=false
		type.RAIN:rain.emitting=true
	pass
	

func _physics_process(delta):
	translate(velocity * delta)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass
