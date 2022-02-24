extends AnimatedSprite

onready var coin_collect_SFX = get_node("/root/AudioManager/SFX/CoinCollect")
onready var player_data = get_node("/root/PlayerData")

func _on_body_entered(body):
	if body is Player:
		coin_collect_SFX.play()
		player_data.coins += 1
		queue_free()
