extends Machine
func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(0,1),Vector2(1,1)]
	output_position = Vector2(1,0)
	output_type = ResourceType.ELECTRICAL_ENERGY
	inputs_positions = {ResourceType.MECHANICAL_ENERGY: Vector2(0,1)}
	inputs = {ResourceType.MECHANICAL_ENERGY: false}
