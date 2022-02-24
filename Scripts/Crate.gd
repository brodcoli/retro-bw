extends Entity

class_name Crate

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP);
	add_gravity_to_velocity()
	
	position = position.round()
	
