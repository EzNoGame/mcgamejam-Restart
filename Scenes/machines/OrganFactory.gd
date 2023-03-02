extends Machine

func _init():
	shape = [Vector2(1,0),Vector2(2,0),Vector2(0,1),Vector2(1,1),Vector2(1,2)]
	output_position = Vector2(1,2)
	output_type = ResourceType.ORGANS
	inputs_positions = {ResourceType.METAL: Vector2(1,1),ResourceType.TISSUE:Vector2(2,0)}
	inputs = {ResourceType.METAL: false, ResourceType.TISSUE: false}
