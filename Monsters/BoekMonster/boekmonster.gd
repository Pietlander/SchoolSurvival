extends CharacterBody2D

var speed: float = 100.0
var player: Node2D
var health: int = 3

var is_hurt: bool = false 

@onready var animated_sprite = $AnimatedSprite2D 

@onready var attack_range = $AttackRange 

var attack_damage: int = 1
var can_attack: bool = true
@export var exp_scene: PackedScene # Sleep hier je ExpGem.tscn in!

func _physics_process(delta):
	if is_hurt:
		return 
		
	if player:
		var difficulty_speed = speed + (player.level * 15)
		var distance = global_position.distance_to(player.global_position)
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
			# Monster rent achter speler aan
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * difficulty_speed
			
			# Tip: Verander "Idel" hier naar je ren-animatie, bijvoorbeeld "Running"
			animated_sprite.play("Idel")
			
		
		move_and_slide()

func die(): 
	# Spawn EXP
	if exp_scene:
		var gem = exp_scene.instantiate()
		gem.global_position = global_position
		
		# VERBETERD: We gebruiken call_deferred om hem uitgesteld toe te voegen!
		get_tree().current_scene.add_child.call_deferred(gem)
	
	queue_free()

# Pas je bestaande take_damage aan:
func take_damage(amount: int):
	health -= amount 
	if health <= 0:
		die() # Roep de nieuwe functie aan
	else:
		is_hurt = true
		velocity = Vector2.ZERO 
		animated_sprite.play("Hurt")
		
		await get_tree().create_timer(0.1).timeout
		
		is_hurt = false
