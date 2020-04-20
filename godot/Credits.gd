extends Control

onready var anim = $AnimationPlayer

func _ready():
	yield(get_tree().create_timer(2), "timeout")
	anim.play("Appears")
	
func _input(event):
	if event is InputEventMouseButton:
		if anim.is_playing():
			anim.seek(anim.current_animation_length) 
	


func _on_Button_pressed():
	get_tree().change_scene("res://MainScreen.tscn")
