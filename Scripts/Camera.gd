extends Camera2D

onready var _player = get_node("../Player")

var follow_player = true

func _process(delta: float):
	if follow_player: position = _player.position
