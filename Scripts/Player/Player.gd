extends Entity

class_name Player

onready var player_data = get_node("/root/PlayerData")
onready var audio = get_node("/root/Audio")

onready var main_sprite = $MainSprite
onready var backpack_sprite = $Flippables/BackpackSprite
onready var selection = $Selection
onready var crate_spawn = $Flippables/CrateSpawnLocation
onready var camera = get_node("../Camera")
onready var level_complete = get_node("../CanvasLayer/LevelComplete")
onready var _tag = get_node("Tag")

onready var animation_manager = $Managers/AnimationManager as Player_animation_manager
onready var crate_manager = $Managers/CrateManager as Player_crate_manager

const speed = 70
const jump_power = 200
const jump_power_cut = 40 #jump power that is set when you release up key early
const hurt_time = 3000

var is_jumping = false
var reached_level_finish = false
var is_hurting = false
var hurt_start_time = 0
var is_dead = false
	
func get_horizontal_input():
	return int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
func jump():
	audio.jump.play()
	velocity.y = -jump_power
	is_jumping = true
	
func early_jump_release():
	velocity.y = -jump_power_cut
	
func hurt():
	var now = OS.get_ticks_msec()
	if is_hurting:
		return
	player_data.health -= 1
	if player_data.health <= 0 and not is_dead:
		is_dead = true
		die()
	elif not is_dead:
		is_hurting = true
		hurt_start_time = now
		audio.hurt.play()
	
func die():
	is_dead = true
	velocity.x = 0
	animation_manager.play("die")
	audio.death.play()
	backpack_sprite.visible = false
	get_tree().get_nodes_in_group("dead_text")[0].visible = true
	
	

var frame = 0
func _process(delta):
	if is_hurting:
		if frame % 5 == 0:
			visible = !visible
		frame += 1
		
	if crate_manager.ready_to_pick_up_crate():
		crate_manager.display_selection_at_nearest_crate()
		_tag.text = "S to take"
	elif crate_manager.holding_crate:
		crate_manager.display_selection_at_placement()
		_tag.text = "S to place"
	else:
		selection.visible = false
		_tag.text = ""

func _physics_process(delta):
	var now = OS.get_ticks_msec()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	add_gravity_to_velocity()
	
	if is_hurting:
		var time_hurting = now - hurt_start_time
		if time_hurting >= hurt_time:
			is_hurting = false
			visible = true
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision and collision.collider is TileMap:
			var pos = collision.collider.world_to_map(position)
			pos -= collision.normal
			var tile = collision.collider.get_cellv(pos)
			
			if tile == 13:
				hurt()
	
	if is_on_floor():
		is_jumping = false
	
	if not reached_level_finish and not is_dead:
		var inputX = get_horizontal_input()
		
		if abs(inputX) > 0:
			animation_manager.play("run")
		else:
			animation_manager.play("idle")
		
		velocity.x = inputX
		velocity.x *= speed
	
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			jump()
		if(Input.is_action_just_released("ui_up") and is_jumping and velocity.y < -jump_power_cut):
			early_jump_release()
		if(Input.is_action_just_pressed("ui_down")):
			if crate_manager.ready_to_pick_up_crate():
				crate_manager.pick_up_crate()
			elif crate_manager.holding_crate:
				if crate_manager.current_crate_spawn_location_is_valid():
					crate_manager.place_down_crate()
				else:
					audio.invalid.play()
		
	main_sprite.set_flip_h(is_flipped())
	if(just_flipped()):
		for node in $Flippables.get_children():
			node.position.x *= -1
			if node is Sprite or node is AnimatedSprite:
				node.set_flip_h(is_flipped())
				
func level_finish():
	reached_level_finish = true
	animation_manager.play("run")
	velocity = Vector2(speed, 0)
	camera.follow_player = false
	level_complete.visible = true

func closest_crate_sort(crateA, crateB):
	var p = position
	var a = crateA.position + Vector2(4, 4)
	var b = crateB.position + Vector2(4, 4)
	if (a - p).length() < (b - p).length():
		return true
	return false

func _on_interact_body_enter(body):
	if body is Crate:
		crate_manager.interact_crates.append(body)
		crate_manager.interact_crates.sort_custom(self, "closest_crate_sort")

func _on_interact_body_exited(body):
	if body is Crate:
		crate_manager.remove_crate_from_array(body)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
