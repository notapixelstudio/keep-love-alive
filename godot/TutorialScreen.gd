extends Control


func _on_Start_pressed():
	get_tree().change_scene_to_file("res://World.tscn")


func _on_Area2D_body_entered(body):
	if body.is_in_group('lovers'):
		get_tree().change_scene_to_file("res://World.tscn")
