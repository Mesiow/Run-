extends KinematicBody2D

var velocity=Vector2()
var jumpSpeed=480.0
var speed = 150

const gravity=310.0

onready var sprite=get_node("Sprite")
onready var jump=$Jump
onready var died=$Died

signal playerDied
var dead=false

var score = 0

func _ready():
	set_process(true)
	set_physics_process(true)
	self.connect("playerDied", get_parent().get_node("Environment"), "on_PlayerDied")
	self.connect("playerDied" , get_parent().get_node("Score"), "on_PlayerDied")
	pass
	
	
func _physics_process(delta):
	if !dead:
		velocity.y += gravity * 6.0 * delta
		velocity = move_and_slide(velocity, Vector2(0, -1))
		#yield(get_tree().create_timer(1.0),"timeout")
		score+=1
		
		if Input.is_action_pressed("ui_select") and is_on_floor():
			velocity.y = -jumpSpeed
			jump.play()
	
		if Input.is_action_pressed("left"):
			velocity.x = -speed 
		elif Input.is_action_pressed("right"):
			velocity.x = speed
		else:
			velocity.x=0
			
		global_position.x = clamp(global_position.x, 5, get_viewport_rect().size.x) #keep player in the window
	pass

	
func kill():
	emit_signal("playerDied")
	#freeze character in place
	velocity.y = 0
	dead=true
	died.play()
	pass