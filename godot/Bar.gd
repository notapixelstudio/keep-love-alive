extends Node2D

export var player = 'p1'
export var auto_recolor = true
export var auto_update = true

func _ready():
	if auto_recolor:
		$Heart.modulate = global.players[player].color
		$BrokenHeart.modulate = global.players[player].color
		$LifeBar.modulate = global.players[player].color
		$LoveBar.modulate = global.players[player].color
	if auto_update:
		update()
	
func update():
	$LifeBar.value = global.players[player].life
	$LoveBar.value = global.players[player].love
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	if $LoveBar.value == 0:
		$Heart.visible = false
		$BrokenHeart.visible = true
		$break.play()
		
