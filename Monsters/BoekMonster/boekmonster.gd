extends CharacterBody2D

var speed: float = 100.0
var player: Node2D
var stop_distance: float = 40.0
var health: int = 3


var is_hurt: bool = false 

@onready var animated_sprite = $AnimatedSprite2D 

func _physics_process(_delta):
	
	if is_hurt:
		return 
		
	if player:
		var distance = global_position.distance_to(player.global_position)
		
		if distance > stop_distance:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			animated_sprite.play("Idel") 
		else:
			velocity = Vector2.ZERO
			animated_sprite.play("Idel")
			
		move_and_slide()

func take_damage(amount: int):
	health -= amount 
	
	if health <= 0:
		queue_free()
	else:
	
		is_hurt = true
		velocity = Vector2.ZERO 
		animated_sprite.play("Hurt")
		
		
		await get_tree().create_timer(0.1).timeout
		
	
		is_hurt = false
