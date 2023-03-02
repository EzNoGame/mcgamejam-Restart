extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(2,0)]
	output_position = Vector2.ZERO
	output_type = ResourceType.MECHANICAL_ENERGY
	inputs_positions = {ResourceType.METAL: Vector2(2,0)}
	inputs = {ResourceType.METAL: false}
