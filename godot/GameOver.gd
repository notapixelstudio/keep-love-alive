extends Control

onready var p_name = $SendToLeaderboard/Name
onready var score_label = $Score
var score = 0

func _ready():
	visible = false
	
	
func start(time):
	visible = true
	score = time
	score_label.text = global.sec_to_min(score, false)
	

func _on_Retry_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_BackMenu_pressed():
	get_tree().change_scene("res://MainScreen.tscn")

func _on_Button_pressed():
	var player_name = p_name.text
	SilentWolf.Scores.persist_score(player_name, score)
	get_tree().change_scene("res://Leaderboard.tscn")
	
