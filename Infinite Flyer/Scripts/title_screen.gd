extends Control

@onready var score = $Score

func _ready():
	score.text = "High Score: " + str(Global.highscore)

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
