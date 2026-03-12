extends CharacterBody2D

# Tweak these numbers until it feels perfect for your game
const MAX_SPEED = 100.0
const ACCELERATION = 600.0
const FRICTION = 800.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		# If the player is pressing a key, accelerate towards the max speed
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		# If no keys are pressed, apply friction to slide to a stop
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
