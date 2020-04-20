extends Node

const DEFAULT_PLAYERS = {
	'p1': {'life': 100, 'love': 50, 'color': Color('ffcc00')},
	'p2': {'life': 100, 'love': 50, 'color': Color('00ccff')}
}

onready var players = DEFAULT_PLAYERS.duplicate(true)

func _ready():
	SilentWolf.configure({
		"api_key": "nhEiDdEK5E8PAowwDabV18piLmLK7oIgqOXiFn21",
		"game_id": "keep-love-alive",
		"game_version": "1.0.2",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://MainScreen.tscn"
	})

func new_game():
	print(players)
	players = DEFAULT_PLAYERS.duplicate(true)

var timeformat = "{min}:{sec}"
func sec_to_min(seconds: float, ms_bool = true) -> String:
	var m = int(floor(seconds/60))
	var s = int(floor(seconds))%60
	var ms = stepify(seconds,0.1) - int(seconds)
	if ms_bool:
		s = s + ms
	var ss: String = "0"+str(s) if s < 10 else str(s)
	if ss.find(".") < 0:
		ss = ss+".0"
	return timeformat.format({"min": m, "sec": ss})
	
