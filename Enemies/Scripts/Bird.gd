extends Area2D

var velocity=Vector2()
var speed=0

const Projectile=preload("res://Enemies/Scenes/Projectile.tscn")
onready var anim=get_node("AnimatedSprite")
onready var attckTimer=get_node("AttackTimer")

func _ready():
	randomize()
	var randVelX=rand_range(150.0, 250.0)
	speed=randVelX
	velocity=Vector2(-speed, 0)
	
	anim.play("fly")
	attack()
	
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
		body.kill()
	pass
	
func attack():
	var proj=Projectile.instance()
	proj.position = position
	get_tree().get_root().get_node("/root/World").call_deferred("add_child", proj)
	attckTimer.start()
	pass


func _on_AttackTimer_timeout():
	attack()
	pass
	
func stopAttack():
	attckTimer.stop()
	pass
