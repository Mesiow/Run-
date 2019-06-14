extends TextureButton

func _ready():
	pass

func _on_RestartBtn_pressed():
	get_tree().reload_current_scene()
	pass
