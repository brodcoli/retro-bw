extends Node2D

onready var player_data = get_node("/root/PlayerData")

func _process(delta):
	$Coins/CoinCount.text = player_data.coins as String
