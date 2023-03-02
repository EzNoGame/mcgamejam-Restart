extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(2,0),Vector2(0,1),Vector2(0,2)]
	output_position = Vector2(0,2)
	output_type = ResourceType.BLOOD
	inputs_positions = {ResourceType.CARBON: Vector2(0,1),ResourceType.WATER:Vector2(2,0)}
	inputs = {ResourceType.CARBON: false, ResourceType.WATER: false}
