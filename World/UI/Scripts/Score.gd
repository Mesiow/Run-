extends Control

onready var player=get_parent().get_node("Player")
onready var currScore=$CurrentScore
onready var hiScore=$HighScore

func _ready():
	pass
	
func _process(delta):
	currScore.text = "Score " + str(player.score)
	pass