extends Node2D

onready var tween = $Tween



func _on_Retry_pressed():
	if tween.is_active():
		return
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(1,0), 0.5,Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")
	$Second.visible = true
	tween.interpolate_property(self, "scale", Vector2(1, 0), Vector2(1,1), 0.5,Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
	
	


func _on_Basic_pressed():
	if tween.is_active():
		return
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(1,0), 0.5,Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")
	get_tree().change_scene("res://World.tscn")
