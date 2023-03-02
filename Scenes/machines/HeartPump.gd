extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(2,0), Vector2(0,1), Vector2(1,1),Vector2(2,1),Vector2(1,2)]
	output_position = Vector2(0,1)
	output_type = ResourceType.HEART_PUMP
	inputs_positions = {ResourceType.TISSUE: Vector2(0,0),ResourceType.BLOOD:Vector2(2,1),ResourceType.ELECTRICAL_ENERGY:Vector2(1,2)}
	inputs = {ResourceType.TISSUE: false, ResourceType.BLOOD: false, ResourceType.ELECTRICAL_ENERGY: false}
