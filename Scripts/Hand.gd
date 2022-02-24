extends Entity

class_name Hand

func _physics_process(delta):
	pass
	


func _on_attack_body_entered(body):
	if body is Player:
		$AnimatedSprite.play("grab")
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.play("idle")
