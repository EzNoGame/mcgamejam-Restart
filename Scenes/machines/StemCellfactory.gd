extends Machine
func _init():
	shape = [Vector2(0,0),Vector2(0,1),Vector2(0,2)]
	output_position = Vector2(0,2)
	output_type = ResourceType.STEM_CELL
	inputs_positions = {ResourceType.HYDROCARBON: Vector2(0,0)}
	inputs = {ResourceType.HYDROCARBON: false}
