extends Node

class_name Player_animation_manager

onready var _player = get_node("../..")

const _dict = {
	"run": {
		"main": "run",
		"backpack": "run"
	},
	"idle": {
		"main": "idle",
		"backpack": "idle"
	},
	"die": {
		"main": "die",
		"backpack": "idle"
	}
}

func play(name: String):
	var anim = _dict[name]

	if anim.main: _player.main_sprite.play(anim.main)
	if anim.backpack:
		if name == "run":
			_player.backpack_sprite.frame = _player.main_sprite.frame
		_player.backpack_sprite.play(anim.backpack)
