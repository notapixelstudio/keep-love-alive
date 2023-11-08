extends Node2D

@onready var todogroups = get_tree().get_nodes_in_group('todogroups')
@onready var gameover_screen = $CanvasLayer/GameOver
var todogroups_chances = []
var todogroups_chances_max

var time: float = 0.0
@onready var timer_label = $CanvasLayer/TimerLabel

func _ready():
	if global.ai_love:
		$Character_p2.cpu = true
	randomize()
	global.new_game()
	update_bars()
	
	for todogroup in todogroups:
		todogroup.connect('checked', Callable(self, '_on_Todo_checked'))
		
	todogroups.sort_custom(Callable(TodoGroup, 'compare'))
	var sum = 0
	for todogroup in todogroups:
		sum += todogroup.probability
		todogroups_chances.append(sum)
		
	todogroups_chances_max = sum
	
func _on_Timer_timeout():
	for p in ['p1','p2']:
		global.players[p].life -= 1
		if int(global.players[p].time_together) >= 1:
			global.players[p].love += 1
			global.players[p].time_together -= int(global.players[p].time_together)
		else:
			global.players[p].love -= 1
		
		# love can't be more than life
		global.players[p].love = min(global.players[p].love, global.players[p].life)
		
		# check game over
		if global.players[p].love <= 0:
			game_over()
			
	update_bars()


func game_over():
	timer_label.visible = false
	$Timer.stop()
	for lover in get_tree().get_nodes_in_group("lovers"):
		lover.stop()
	set_process(false)
	gameover_screen.start(time)
	
func update_bars():
	for p in ['p1','p2']:
		find_child('Bar_'+p).update()
		
func _on_Todo_checked(todo):
	global.players[todo.player].life = min(global.players[todo.player].life + todo.value, 100)
	update_bars()
	await get_tree().create_timer(2).timeout
	spawn_todo(todo.player)
	
func spawn_todo(player):
	var random = randi() % todogroups_chances_max
	
	var i = 0
	for tgc in todogroups_chances:
		if random < tgc:
			break
		i += 1
		
	todogroups[i].activate(player)
	
func _on_SpawnTimer_timeout():
	spawn_todo(['p1','p2'][randi() % 2])
	$SpawnTimer.wait_time *= 0.9
	$SpawnTimer.wait_time = max($SpawnTimer.wait_time, 2)

func _process(delta):
	time += delta
	timer_label.text = sec_to_min(time)
	for p in ['p1','p2']:
		if find_child('Character_'+p).is_cherised():
			global.players[p].time_together += delta
		
		
	

var timeformat = "{min}:{sec}"
func sec_to_min(seconds: float) -> String:
	var m = int(floor(seconds/60))
	var s = int(floor(seconds))%60
	var ms = snapped(seconds,0.1) - int(seconds)
	s = s + ms
	var ss: String = "0"+str(s) if s < 10 else str(s)
	if ss.find(".") < 0:
		ss = ss+".0"
	return timeformat.format({"min": m, "sec": ss})
	
