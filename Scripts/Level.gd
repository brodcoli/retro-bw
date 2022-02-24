extends Node2D

onready var _title = get_node("../CanvasLayer/Title")
onready var _data = get_node("Data")

func _ready():
	_title.display("LEVEL " + _data.get_node("Level").text)
