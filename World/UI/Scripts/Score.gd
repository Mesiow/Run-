extends Control

onready var player=get_parent().get_node("Player")
onready var currScore=$CurrentScore
onready var hiScore=$HighScore

func _ready():
	loadScore()
	pass
	
func _process(delta):
	currScore.text = "Score " + str(player.score)
	pass
	
func on_PlayerDied():
	set_process(false)
	saveScore()
	pass
	
func loadScore():
	var file = File.new()
	if !file.file_exists("high_score.sav"):
		print("High Score file does not exist")
		hiScore.text = "HI " + str(0)
		return
		
	if file.open("high_score.sav", File.READ) != 0:
		print("High Score file failed to open")
		return
		
	hiScore.text = "HI " + str(file.get_line())
	pass
		
func saveScore():
		var scoreLocation=currScore.text.find(" ") + 1 #find the space location
		var currentScore = ""
		for i in range(scoreLocation, currScore.text.length()): #parse current score
			currentScore+=currScore.text[i] #grab current score from string
			
		var hiScoreLocation=hiScore.text.find(" ") + 1
		var highScore = ""
		for i in range (hiScoreLocation, hiScore.text.length()): #parse high score
			highScore+=hiScore.text[i]
		
		if int(currentScore) <= int(highScore):
			return
			
		highScore = currentScore #set high score to the new current score
		hiScore.text = "HI " + str(highScore)
	
		#save high score to a file
		var file = File.new()
		if file.open("high_score.sav", File.WRITE) != 0: #open the file and set it up for writing to it
			print("File failed to open")
			return
		
		#save high score as json
		file.store_line(highScore)
		file.close()
		pass