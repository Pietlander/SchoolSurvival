extends TileMapLayer

@export var map_width: int = 200
@export var map_height: int = 200


@export var terrain_set_index: int = 0
@export var floor_terrain_index: int = 0 


@export var wall_source_id: int = 1               
@export var wall_atlas_coords: Vector2i = Vector2i(0, 0) 

func _ready() -> void:
	generate_terrain()

func generate_terrain() -> void:
	var all_floor_cells: Array[Vector2i] = []
	var floor_cells_to_rotate: Array[Vector2i] = []
	var wall_cells: Array[Vector2i] = []
	
	var half_width = map_width / 2
	var half_height = map_height / 2
	
	
	for x in range(-half_width, half_width):
		for y in range(-half_height, half_height):
			var current_cell = Vector2i(x, y)
			
			
			all_floor_cells.append(current_cell)
			
			
			if x == -half_width or x == half_width - 1 or y == -half_height or y == half_height - 1:
				wall_cells.append(current_cell)
			else:
				floor_cells_to_rotate.append(current_cell)
	
	
	set_cells_terrain_connect(all_floor_cells, terrain_set_index, floor_terrain_index, true)
	
	
	for cell in wall_cells:
		set_cell(cell, wall_source_id, wall_atlas_coords)
	
	
	randomize_rotations(floor_cells_to_rotate)

func randomize_rotations(cells: Array[Vector2i]) -> void:
	var rotations = [
		0, 
		TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
		TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
		TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V
	]
	
	for cell in cells:
		var source_id = get_cell_source_id(cell)
		var atlas_coords = get_cell_atlas_coords(cell)
		
		var random_rotation = rotations.pick_random()
		if source_id != -1:
			set_cell(cell, source_id, atlas_coords, random_rotation)
