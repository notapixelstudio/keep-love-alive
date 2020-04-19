extends Node

var DEFAULT_PLAYERS = {
	'p1': {'life': 100, 'love': 50, 'color': Color('ffcc00')},
	'p2': {'life': 100, 'love': 50, 'color': Color('00ccff')}
}

onready var players = DEFAULT_PLAYERS

func new_game():
	players = DEFAULT_PLAYERS
