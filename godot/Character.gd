extends KinematicBody2D

class_name Character

export var player = 'p1'
export var speed = 400
export var jump_speed = 600
export var gravity = 1400
export var paused = false

var velocity = Vector2()

func _ready():
	$Sprite.modulate = global.players[player].color
	$Light2D.color = global.players[player].color
	set_process(not paused)
	
	
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
			return aim(area.get_parent())
	return false

var vis_color = Color(.867, .91, .247, 0.1)
var hit_pos = []
var laser_color = Color(1.0, .329, .298)
var radius = 150

"""
# in order to raycast
func _physics_process(delta):
	update()
"""

func aim(lover = null):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state

	var target = self if not lover else lover
	var target_extents = target.get_node('CollisionShape2D').shape.extents - Vector2(5, 5)
	
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position]:
		
		var result = space_state.intersect_ray(position,
				pos, [self], self.collision_mask)
		if result:
			hit_pos.append(result.position)
			if result.collider.name == lover.name:
				return true
			else:
				return false
			
			

func _draw():
	
	#draw_circle(Vector2(), radius, vis_color)
	for hit in hit_pos:
		draw_circle((hit - position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(), (hit - position).rotated(-rotation), laser_color)
	
