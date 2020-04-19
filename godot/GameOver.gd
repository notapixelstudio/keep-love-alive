extends Control

func _ready():
	visible = false
	
	
func start():
	visible = true


func _on_Retry_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_BackMenu_pressed():
	get_tree().change_scene("res://MainScreen.tscn")
