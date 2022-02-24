extends Node2D


func _on_body_entered(body):
	if body is Player:
		body.level_finish()
