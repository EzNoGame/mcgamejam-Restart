extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(1,1),Vector2(1,2)]
	output_position = Vector2(1,2)
	output_type = ResourceType.TISSUE
	inputs_positions = {ResourceType.STEM_CELL: Vector2(1,1)}
	inputs = {ResourceType.STEM_CELL: false}
