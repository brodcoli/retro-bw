extends Node

class_name Player_crate_manager

onready var _player = get_node("../..")
onready var _crate_node = preload("res://Sprites/Crate.tscn")

var interact_crates = []
var holding_crate = false
	
func display_selection_at_nearest_crate():
	_player.selection.visible = true
	_player.selection.global_position = interact_crates[0].global_position
	
func display_selection_at_placement():
	_player.selection.visible = true
	_player.selection.position = _player.crate_spawn.position - Vector2(4, 0)
	
func ready_to_pick_up_crate():
	return interact_crates.size() > 0 and not holding_crate

func remove_crate_from_array(crate: Crate):
	var index = interact_crates.find(crate)
	interact_crates.remove(index)
	
func pick_up_crate():
	var crate = interact_crates[0]
	
	crate.queue_free()
	holding_crate = true
	
	_player.backpack_sprite.visible = true
	_player.backpack_sprite.play("pick up")
	
	_player.audio.pick_up.play()
	
func current_crate_spawn_location_is_valid():
	return _player.crate_spawn.get_overlapping_bodies().size() == 0
	
func place_down_crate():
	holding_crate = false
	var crate = _crate_node.instance()
	crate.position = _player.crate_spawn.global_position - Vector2(4, 0)
	get_tree().get_root().add_child(crate)
	
	_player.backpack_sprite.visible = false
	_player.backpack_sprite.play("idle")
	
	_player.audio.place_down.play()
