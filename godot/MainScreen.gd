extends Control

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
	
	yield(get_tree().create_timer(1), "timeout")
	SilentWolf.Scores.persist_score("first", 1.8)
	yield(get_tree().create_timer(2), "timeout")
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	print("Scores: " + str(SilentWolf.Scores.scores))
