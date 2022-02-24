extends SideStepper

onready var sprite = get_node("AnimatedSprite")

func _physics_process(delta):
	zero_velocity_until_near_player()
	
	velocity = move_and_slide(velocity, Vector2.UP);
	set_velocity_and_update()
	add_gravity_to_velocity()
