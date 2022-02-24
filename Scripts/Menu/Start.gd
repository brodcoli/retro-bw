extends Node2D

var _origin_x: int

func _ready():
	_origin_x = position.x

func _process(delta: float):
	var time = OS.get_ticks_msec() as float
	var d = time / 200
	var radius = 3
	
	position.x = round(sin(d) * radius + _origin_x)
