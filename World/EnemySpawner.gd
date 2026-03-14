extends Node2D

@export var monster_scene: PackedScene  
@export var player: Node2D             
@export var spawn_radius: float = 500.0 

var current_wave: int = 1
var base_monsters: int = 3

func _ready():

	start_wave()
	
	
	$WaveTimer.wait_time = 10.0 
	$WaveTimer.timeout.connect(start_wave)
	$WaveTimer.start()

func start_wave():

	var monsters_to_spawn = base_monsters + (current_wave * 2) 
	
	for i in range(monsters_to_spawn):
		spawn_monster()
		
	print("Wave ", current_wave, " started with ", monsters_to_spawn, " monsters!")
	current_wave += 1

func spawn_monster():
	if not player or not monster_scene:
		push_warning("Player or Monster Scene is not assigned!")
		return
		
	var monster = monster_scene.instantiate()
	
	
	monster.player = player 
	
	var random_angle = randf() * TAU 
	var spawn_direction = Vector2.RIGHT.rotated(random_angle)
	var spawn_position = player.global_position + (spawn_direction * spawn_radius)
	
	monster.global_position = spawn_position
	
	get_tree().current_scene.add_child.call_deferred(monster)
