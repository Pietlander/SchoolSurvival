extends CharacterBody2D

var speed: float = 100.0
var player: Node2D
var health: int = 3

var is_hurt: bool = false 

@onready var animated_sprite = $AnimatedSprite2D 

@onready var attack_range = $AttackRange 

var attack_damage: int = 1
var can_attack: bool = true

func _physics_process(delta):
	if is_hurt:
		return 
		
	if player:
		var is_player_in_range = false
		
		for body in attack_range.get_overlapping_bodies():
			if body == player:
				is_player_in_range = true
				break
		
		if is_player_in_range:
		
			velocity = Vector2.ZERO
			animated_sprite.play("Idel") 
			
			if can_attack and player.has_method("take_damage"):
				player.take_damage(attack_damage)
				can_attack = false
				await get_tree().create_timer(1.0).timeout
				can_attack = true
		else:
		
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			animated_sprite.play("Idel") 
			
		
		move_and_slide()

func take_damage(amount: int):
	health -= amount 
	
	if health <= 0:
		queue_free()
		set_physics_process(false)
	else:
		is_hurt = true
		velocity = Vector2.ZERO 
		animated_sprite.play("Hurt")
		
		await get_tree().create_timer(0.1).timeout
		
		is_hurt = false
