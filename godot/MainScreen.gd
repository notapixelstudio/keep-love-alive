extends Control

func _ready():
	global.play_menu()
	
func _on_Credits_pressed():
	get_tree().change_scene("res://Credits.tscn")


func _on_Leaderboard_pressed():
	get_tree().change_scene("res://Leaderboard.tscn")
