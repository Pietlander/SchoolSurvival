extends CharacterBody2D

signal health_changed(new_health)

const MAX_SPEED = 400.0
const ACCELERATION = 600.0
const FRICTION = 800.0

@onready var animated_sprite = $AnimatedSprite2D


@export var bullet_scene: PackedScene 

var can_shoot: bool = true
var fire_rate: float = 0.5 


var max_health: int = 5
var current_health: int = 5
var is_invincible: bool = false # GOD MODE 

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
	
	if not can_shoot:
		return
		
	
	if not bullet_scene:
		push_warning("Bullet scene is not assigned to the player!")
		return
		
	
	can_shoot = false
		

	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	
	var mouse_pos = get_global_mouse_position()
	bullet.direction = global_position.direction_to(mouse_pos)
	
	get_tree().current_scene.add_child.call_deferred(bullet)

	
	
	await get_tree().create_timer(fire_rate).timeout
	
	
	can_shoot = true
	

func take_damage(amount: int):
	if is_invincible:
		return
		
	current_health -= amount
	
	
	health_changed.emit(current_health)
	
	if current_health <= 0:
		die()
	else:
		is_invincible = true
		await get_tree().create_timer(1.0).timeout
		is_invincible = false

func die():
	print("Player Died! Game Over.")
	
	get_tree().reload_current_scene()
