extends Node2D

@export var monster_scene: PackedScene  
@export var player: Node2D
@export var tilemap_layer: TileMapLayer 
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
	if not player or not monster_scene or not tilemap_layer:
		push_warning("Player, Monster Scene, of TileMapLayer is niet gekoppeld in de Inspector!")
		return
		
	var monster = monster_scene.instantiate()
	monster.player = player 
	
	var valid_position_found = false
	var final_spawn_pos = Vector2.ZERO
	var attempts = 0
	var max_attempts = 15 
	
	while not valid_position_found and attempts < max_attempts:
		attempts += 1
		
		# Bedenkt een random positie in de wereld
		var random_angle = randf() * TAU 
		var spawn_direction = Vector2.RIGHT.rotated(random_angle)
		var test_position = player.global_position + (spawn_direction * spawn_radius)
		
		# Zet de wereld-positie om naar de coördinaten van het grid
		var map_position = tilemap_layer.local_to_map(test_position)
		
		#vraag de data op (zonder laag-nummer, want de node is al de laag!)
		var tile_data = tilemap_layer.get_cell_tile_data(map_position)
		
		# Check of het vakje bestaat én of onze custom 'can_spawn' sticker op True staat!
		if tile_data and tile_data.get_custom_data("can_spawn") == true:
			final_spawn_pos = test_position
			valid_position_found = true
			
	# Als we na 15 pogingen een plek hebben gevonden, spawnen we het monster
	if valid_position_found:
		monster.global_position = final_spawn_pos
		get_tree().current_scene.add_child.call_deferred(monster)
	else:
		print("Kon geen geschikte vloer-locatie vinden voor een monster!")
