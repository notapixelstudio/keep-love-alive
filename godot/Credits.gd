extends Control

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("Appears")
	
func _input(event):
	if event is InputEventMouseButton:
		if anim.is_playing():
			anim.seek(anim.current_animation_length) 
	


func _on_Button_pressed():
	get_tree().change_scene_to_file("res://MainScreen.tscn")
