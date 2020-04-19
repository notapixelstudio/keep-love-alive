extends Node

const DEFAULT_PLAYERS = {
	'p1': {'life': 100, 'love': 50, 'color': Color('ffcc00')},
	'p2': {'life': 100, 'love': 50, 'color': Color('00ccff')}
}

onready var players = DEFAULT_PLAYERS.duplicate(true)

func new_game():
	print(players)
	players = DEFAULT_PLAYERS.duplicate(true)
