extends Entity

class_name SideStepper

const speed = 40
var direction = Vector2.LEFT;

var _was_just_on_wall = false

func set_velocity_and_update():
	velocity.x = direction.x * speed
	
	if is_on_wall() and not _was_just_on_wall:
		direction *= -1
		move_and_slide(direction * speed, Vector2.UP)
		_was_just_on_wall = true
	else:
		_was_just_on_wall = false
