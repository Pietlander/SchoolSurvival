extends CharacterBody2D

const MAX_SPEED = 400.0
const ACCELERATION = 600.0
const FRICTION = 800.0

@onready var animated_sprite = $AnimatedSprite2D


@export var bullet_scene: PackedScene 

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		animated_sprite.play("Running")
		
		if direction.x != 0:
			animated_sprite.flip_h = (direction.x < 0)
	else:
		animated_sprite.play("idel") 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	
	if not bullet_scene:
		push_warning("Bullet scene is not assigned to the player!")
		return
		
	var bullet = bullet_scene.instantiate()
	
	
	bullet.global_position = global_position
	
	
	var mouse_pos = get_global_mouse_position()
	bullet.direction = global_position.direction_to(mouse_pos)
	
	
	get_tree().current_scene.add_child.call_deferred(bullet)
