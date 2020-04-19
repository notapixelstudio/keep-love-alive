extends KinematicBody2D

class_name Character

export var player = 'p1'
export var speed = 400
export var jump_speed = 600
export var gravity = 1400

var velocity = Vector2()

func _ready():
	$Sprite.modulate = global.players[player].color
	if player == 'p1':
		$Circle.player = 'p2'
	else:
		$Circle.player = 'p1'

func _process(delta):
	var dir_x = int(Input.is_action_pressed(player+'_right'))-int(Input.is_action_pressed(player+'_left'))
	velocity.x = speed*dir_x
	
	if is_on_floor():
		if Input.is_action_pressed(player+'_jump'):
			if not Input.is_action_pressed(player+'_down'):
				velocity.y = -jump_speed
			else:
				position.y += 2
	else:
		# different gravity while acending or falling
		if velocity.y < 0 and Input.is_action_pressed(player+'_jump'):
			velocity.y += gravity*delta
		else:
			velocity.y += 2*gravity*delta
			
	velocity = move_and_slide(velocity, Vector2(0,-1))

func is_cherised():
	for area in $CheckCherised.get_overlapping_areas():
		if area != $Circle and area.is_in_group('cherish'):
			return true
	return false
	
