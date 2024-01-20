extends Node

var highscore = 0
var score_file = "user://hs.dat"

func _ready():
	load_score()

func load_score():
	if FileAccess.file_exists(score_file):
		var file = FileAccess.open(score_file,FileAccess.READ)
		highscore = file.get_var()
	else:
		highscore = 0

func save_score():
	var file = FileAccess.open(score_file,FileAccess.WRITE)
	file.store_var(highscore)
