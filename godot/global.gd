extends Node

const DEFAULT_PLAYERS = {
	'p1': {'life': 100, 'last_checked':0.0, 'time_together': 0.0, 'love': 50, 'color': Color('ffcc00')},
	'p2': {'life': 100, 'last_checked':0.0, 'time_together': 0.0 , 'love': 50, 'color': Color('00ccff')}
}

onready var players = DEFAULT_PLAYERS.duplicate(true)
onready var audio = AudioStreamPlayer.new()
var in_game = false
var ai_love: bool = false

func play_menu():
	if in_game or not audio.stream:
		audio.stream = load("res://assets/bgm/362814__setuniman__heartbroken-1n99.ogg")
		audio.play()
	
func _ready():
	
	add_child(audio)
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
	in_game = true
	audio.stream = load("res://assets/bgm/403968__setuniman__childhood-1p63.wav")
	audio.play()
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
	
