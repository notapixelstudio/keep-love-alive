extends Node2D

export var player = 'p1'

func _ready():
	$Heart.modulate = global.players[player].color
	$LoveBar.modulate = global.players[player].color
	update()
	
func update():
	$LifeBar.value = global.players[player].life
	$LoveBar.value = global.players[player].love
	
