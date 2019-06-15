extends Node2D

const Asteroid=preload("res://Enemies/Scenes/Asteroid.tscn")
const Cloud=preload("res://World/Cloud.tscn")
const Cactus=preload("res://Obstacles/Scenes/Cactus.tscn")
const Bird=preload("res://Enemies/Scenes/Bird.tscn")

onready var cloudTimer=get_node("CloudSpawnTimer")
onready var birdTimer=get_node("BirdSpawnTimer")
onready var cactiTimer=get_node("CactiSpawnTimer")
onready var astTimer=get_node("AsteroidSpawnTimer")
onready var ground=get_node("Ground")

onready var player=get_parent().get_node("Player")

signal playerDied

func _ready():
	self.connect("playerDied", get_parent(), "on_PlayerDeath")
	spawnObstacles()
	pass
	
func spawnObstacles():
	yield(get_tree().create_timer(1.0), "timeout")
	spawnCloud()
	spawnBird()
	spawnCactus()
	spawnAsteroid()
	pass
	
	
func spawnCloud():
	randomize()
	cloudTimer.wait_time = rand_range(0.1, 10.0)
	
	var cloud=Cloud.instance()
	var spawnPositionX=rand_range(get_viewport_rect().size.x, get_viewport_rect().size.x * 1.5) #spawn outside of the view 
	var spawnPositionY=rand_range(32.0, get_viewport_rect().size.y / 2.5)
	cloud.global_position=Vector2(spawnPositionX, spawnPositionY)
	add_child(cloud)
	
	cloudTimer.start()
	pass
	
func spawnBird():
	randomize()
	birdTimer.wait_time=rand_range(1.0, 20.0)
	
	var bird=Bird.instance()
	var spawnX=rand_range(get_viewport_rect().size.x, get_viewport_rect().size.x * 1.5)
	var spawnY=rand_range(get_viewport_rect().size.y / 2, ground.global_position.y - 100)
	
	bird.global_position=Vector2(spawnX, spawnY)
	add_child(bird)
	
	birdTimer.start()
	pass
	
func spawnCactus():
	randomize()
	cactiTimer.wait_time=rand_range(0.5, 1.5)
	
	var cactus=Cactus.instance()
	var spawnX=rand_range(get_viewport_rect().size.x, get_viewport_rect().size.x * 1.5)
	var spawnY=ground.global_position.y - cactus.get_node("Sprite").get_rect().size.y / 3.5
	cactus.global_position=Vector2(spawnX, spawnY)
	add_child(cactus)
	
	cactiTimer.start()
	pass
	
func spawnAsteroid():
	randomize()
	astTimer.wait_time = rand_range(5.0, 20.0)
	var spawnX = rand_range(get_viewport_rect().size.x * 1.5, get_viewport_rect().size.x * 2)
	var spawnY = 50
	
	var asteroid=Asteroid.instance()
	asteroid.global_position = Vector2(spawnX, spawnY)
	
	#calc direction from player to spawned asteroid
	var direction = (asteroid.global_position - player.global_position).normalized() #grab direction vector
	asteroid.setDir(direction) #set the asteroids direction vector
	add_child(asteroid)
	
	astTimer.start()
	pass


func _on_CloudSpawnTimer_timeout():
	spawnCloud()
	pass


func _on_BirdSpawnTimer_timeout():
	spawnBird()
	pass


func _on_CactiSpawnTimer_timeout():
	spawnCactus()
	pass
	
func _on_AsteroidSpawnTimer_timeout():
	spawnAsteroid()
	pass
	
func stop(): #stops environment movement because we lost
	var children=get_children()
	for i in range(0, children.size()):
		if children[i].has_method("attack"):
			children[i].stopAttack()
		if "velocity" in children[i]: #if any of the children nodes has a velocity variables..
			children[i].velocity=Vector2(0,0)
		if "anim" in children[i]: #if any of the children have an animation var stop the animation
			children[i].anim.stop()
			
	cloudTimer.stop()
	birdTimer.stop()
	cactiTimer.stop()
	pass
	
func on_PlayerDied(): #callback func connected to signal in player
	stop()
	emit_signal("playerDied")
	pass
