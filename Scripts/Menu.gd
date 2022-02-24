extends Node2D

onready var audio = get_node("/root/Audio")

func _process(delta: float):
	if Input.is_action_pressed("ui_accept"):
		audio.start.play()
		get_tree().change_scene("res://Scenes/Main.tscn")
