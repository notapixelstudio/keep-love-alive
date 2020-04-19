extends Node2D


export var radius = 150
export var player = 'p1' setget set_player

func set_player(v):
	player = v
	refresh()

func refresh():
	modulate = global.players[player].color

func _ready():
	refresh()
	$CollisionShape2D.shape.radius = radius
	
	var points = []
	var precision = 0.1
	var alpha = 0
	while alpha < 2*PI:
		points.append(Vector2(radius*cos(alpha), radius*sin(alpha)))
		alpha += precision
	
	$Polygon2D.polygon = PoolVector2Array(points)
	points.append(points[0])
	$Line2D.points = PoolVector2Array(points)
