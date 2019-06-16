extends Area2D

const Impact=preload("res://World/Impact.tscn")
var velocity=Vector2(0,0)
var direction=Vector2(0,0)
var rot = 0

onready var sprite=get_node("Sprite")
onready var particles=get_node("Particles2D")
onready var environment= get_tree().get_root().get_node("/root/World/Environment")
var particleEmitDir

var queueFreePos

func _ready():
	randomize()
	$Particles2D.amount = randi() %40 + 10
	
	var speed = rand_range(-500.0, -600.0)
	if $Particles2D.amount <= 20:
		speed = speed * 0.5 #set speed to half
		
	velocity = Vector2(speed, speed)
	
	var randomRot = rand_range(-0.1, 0.1)
	rot = randomRot
	
	queueFreePos = environment.get_node("Ground").global_position.y
	set_physics_process(true)
	pass
	
	
func setDir(dir):
	direction = dir
	particleEmitDir = direction.direction_to(-direction)
	var angle = particleEmitDir.angle_to(particleEmitDir)
	
	$Particles2D.rotate(angle)
	pass
	
func _physics_process(delta):
	if global_position.y >= queueFreePos:
		var impact = Impact.instance()
		impact.global_position = global_position
		get_tree().get_root().get_node("/root/World").call_deferred("add_child", impact)
		queue_free()

	sprite.rotate(rot)
	translate(velocity * direction * delta)
	pass


func _on_Asteroid_body_entered(body):
	if body.get_name() == "Player":
		body.kill()
	pass
