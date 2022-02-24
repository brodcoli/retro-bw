extends Entity

const wakeup_distance = 30
const sleep_distance = 50
const speed = 10

onready var sprite = get_node("AnimatedSprite")
onready var snoring_sprite = get_node("SnoringSprite")

var awake = false

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP);
	add_gravity_to_velocity()
	
	var vec = player.position - position
	var dist = vec.length()

	if not awake and dist <= wakeup_distance:
		snoring_sprite.visible = false
		sprite.play("wakeup")
		yield(sprite, "animation_finished")
		awake = true
		sprite.play("run")
	elif awake and dist >= sleep_distance:
		awake = false
		velocity.x = 0
		sprite.play("sleep")
		yield(sprite, "animation_finished")
		if not awake: #it is possible for the player to awaken blocky before the sleep animation finishes
			sprite.play("idle")
			snoring_sprite.visible = true
		
	if awake:
		velocity.x = sign(vec.x) * speed
		
	sprite.set_flip_h(is_flipped(true))

