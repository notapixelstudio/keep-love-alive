extends Area2D

export var value = 3
export var player = 'p1'
export var active = false setget set_active
export var couple_chance = 0.2

onready var timer = $Timer
onready var collect_sound = $Collected
func set_active(v):
	active = v
	visible = active

func _ready():
	modulate = global.players[player].color
	set_active(active)
	
signal checked
func _on_Todo_body_entered(body):
	if active and body is Character and body.player == player:
		emit_signal('checked', self)
		timer.stop()
		collect_sound.play()
		set_active(false)
		
func activate(time_passed=20):
	set_active(true)
	timer.wait_time = time_passed
	timer.start()
	
	
func _on_Timer_timeout():
	set_active(false)
