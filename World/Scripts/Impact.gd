extends Particles2D

func _ready():
	restart()
	emitting = true
	one_shot = true
	$ImpactSound.play()
	pass