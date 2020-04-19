extends Node2D

class_name TodoGroup

export var probability = 1

func _ready():
	for todo in get_children():
		todo.connect('checked', self, '_on_Todo_checked')
		
signal checked
func _on_Todo_checked(todo):
	emit_signal('checked', todo)
	
static func compare(a, b):
	if a.probability > b.probability:
		return true
	return false

func activate(player):
	for todo in get_children():
		if todo.player == player and todo.couple_chance > 0:
			todo.activate()
		else:
			# activate the other according to its couple chance
			if randf() < todo.couple_chance:
				todo.activate()
		
