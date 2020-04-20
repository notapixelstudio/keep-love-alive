extends KinematicBody2D

class_name Character

export var player = 'p1'
export var speed = 400
export var jump_speed = 600
export var gravity = 1400
export var paused = false
export var cpu : bool = false

onready var jump_sound = $audiojump
onready var jump_down = $audiodown
var velocity = Vector2()


func _ready():
	$Sprite.modulate = global.players[player].color
	$Light2D.color = global.players[player].color
	set_process(not paused)
	
var target = null
var jump_time = 4
var default_wait_time = 4
var jump_wait_time = 1
var wait_still = 4
var change_still_dir = [-1, 1]
var ind_change = 0
func _process(delta):
	if cpu:
		
		var min_dist = 3000
		for todo in get_tree().get_nodes_in_group("todo"):
			
			if todo.player == player and todo.active:
				var dist = (todo.global_position - position).length()
				if min_dist >= dist:
					min_dist = dist
					target = todo
				
		var dir_x = (target.global_position - position).normalized().x
		if not aim(target, "todo"):
			wait_still -= delta
			if wait_still <= 0:
				ind_change = (ind_change+1)%len(change_still_dir)
				wait_still = default_wait_time + rand_range(1.2, 3.3)
			velocity.x = speed*change_still_dir[ind_change]
		else:
			velocity.x = speed*dir_x
		
		
		jump_time -= delta
		if is_on_floor():
			if jump_time<0:
				velocity.y = -jump_speed*1.6
				jump_time = jump_wait_time + rand_range(1.2, 2.3)
				jump_sound.play()
			else:
				var tile_pos = get_parent().get_node("SolidTiles").world_to_map(position)
				var tile_id = get_parent().get_node("SolidTiles").get_cellv(Vector2(tile_pos.x, tile_pos.y+1))
				if tile_id == 1:
					jump_down.play()
					position.y += 2
				
				
		else:
			# different gravity while acending or falling
			velocity.y += 2*gravity*delta
		
		velocity = move_and_slide(velocity, Vector2(0,-1))
		
		return
		
	var dir_x = int(Input.is_action_pressed(player+'_right'))-int(Input.is_action_pressed(player+'_left'))
	velocity.x = speed*dir_x
	
	if is_on_floor():
		if Input.is_action_pressed(player+'_jump'):
			if not Input.is_action_pressed(player+'_down'):
				jump_sound.play()
				velocity.y = -jump_speed
			else:
				jump_down.play()
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

func aim(lover = null, what = "lover")-> bool:
	hit_pos = []
	var space_state = get_world_2d().direct_space_state

	var target = self if not lover else lover
	var target_extents = target.get_node('CollisionShape2D').shape.extents - Vector2(5, 5)
	
	var nw = target.global_position - target_extents
	#var se = target.position + target_extents
	#var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	#var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.global_position]:
		
		var result = space_state.intersect_ray(position,
				pos, [self], self.collision_mask)
		if result:
			hit_pos.append(result.position)
			if result.collider.name == lover.name and what == "lover":
				return true
			else:
				return false
		elif what == "todo" :
			return true
	return false

func _draw():
	
	#draw_circle(Vector2(), radius, vis_color)
	for hit in hit_pos:
		draw_circle((hit - position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(), (hit - position).rotated(-rotation), laser_color)
	
