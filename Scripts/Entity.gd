extends KinematicBody2D

class_name Entity

onready var player = get_node("/root/Main/Player")

const gravity_acceleration = 7
const gravity_terminal = 100
const zero_velocity_player_min_dist = 130

var velocity = Vector2.ZERO
var is_flipped = false
var last_flipped = false
var was_flipped = false

func add_gravity_to_velocity():
	if(is_on_floor()):
		velocity.y = gravity_terminal
		move_and_slide(Vector2(0, velocity.y), Vector2.UP) #double checks player is on floor by pushing into ground
	
	if(velocity.y < gravity_terminal):
		velocity.y += gravity_acceleration
		
func zero_velocity_until_near_player():
	var dist = (player.position - position).length()
	if dist > zero_velocity_player_min_dist:
		velocity = Vector2.ZERO

func is_flipped(reversed = false):
	if(velocity.x < 0):
		is_flipped = not reversed
	elif(velocity.x > 0):
		is_flipped = reversed
		
	if(last_flipped != is_flipped):
		last_flipped = is_flipped
		was_flipped = true
		
	return is_flipped
	
func just_flipped():
	if was_flipped:
		was_flipped = false
		return true

