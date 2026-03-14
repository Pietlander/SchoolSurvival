extends CharacterBody2D


const MAX_SPEED = 400.0
const ACCELERATION = 600.0
const FRICTION = 800.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		animated_sprite.play("Running")
		
		# Flips the sprite horizontally if moving left (x < 0)
		# Unflips it if moving right (x > 0)
		if direction.x != 0:
			animated_sprite.flip_h = (direction.x < 0)
			
	else:
		# Changed "idel" to "idle" - make sure this matches your exact animation name!
		animated_sprite.play("idel") 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
