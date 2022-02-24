extends Node2D

onready var player_data = get_node("/root/PlayerData")
onready var heart_tex = load("res://Textures/Scoreboard/heart.png")

var last_health = -1

func _draw():
	var pos = Vector2(0, 0)
	for i in player_data.health:
		draw_texture(heart_tex, pos)
		pos.x += 8
		
func _process(delta: float):
	if not player_data.health == last_health:
		last_health = player_data.health
		update()
