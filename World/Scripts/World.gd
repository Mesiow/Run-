extends Node

const Restart=preload("res://World/UI/RestartBtn.tscn")

func _ready():
	pass
	
func on_PlayerDeath():
	var restart=Restart.instance()
	add_child(restart)
	pass