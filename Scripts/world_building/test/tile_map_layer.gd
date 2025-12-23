extends TileMapLayer


func _ready() -> void:
	var occupied_tiles := get_used_cells()
	
	for occupied_tile: Vector2i in occupied_tiles:
		var neighbour_tiles := get_surrounding_cells(occupied_tile)
		for neigbour: Vector2i in neighbour_tiles:
			if get_cell_source_id(neigbour) == -1:
				set_cell(neigbour, 0, Vector2i.ZERO)		
