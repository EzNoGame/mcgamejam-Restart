extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(1,1),Vector2(2,1)]
	output_position = Vector2(2,1)
	output_type = ResourceType.HYDROCARBON
	inputs_positions = {ResourceType.CARBON: Vector2(1,0),ResourceType.WATER:Vector2(1,1)}
	inputs = {ResourceType.CARBON: false, ResourceType.WATER: false}
