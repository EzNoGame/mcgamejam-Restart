extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(0,1),Vector2(0,2),Vector2(1,2),Vector2(2,2)]
	output_position = Vector2(0,1)
	output_type = ResourceType.HUMAN
	inputs_positions = {ResourceType.BLOOD: Vector2(1,0),ResourceType.TISSUE:Vector2(2,2),ResourceType.ELECTRICAL_ENERGY:Vector2(0,0)}
	inputs = {ResourceType.BLOOD: false, ResourceType.TISSUE: false,ResourceType.ELECTRICAL_ENERGY:false}
