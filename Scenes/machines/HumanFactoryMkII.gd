extends Machine

func _init():
	shape = [Vector2(0,0),Vector2(1,0),Vector2(0,1),Vector2(0,2),Vector2(1,2),Vector2(2,2)]
	output_position = Vector2(0,1)
	output_type = ResourceType.HUMAN
	inputs_positions = {ResourceType.HEART_PUMP: Vector2(0,0),ResourceType.ELECTRICAL_ENERGY:Vector2(1,0),ResourceType.ORGANS:Vector2(2,2)}
	inputs = {ResourceType.HEART_PUMP: false, ResourceType.ELECTRICAL_ENERGY: false, ResourceType.ORGANS: false}


func end():
	Transition.change_scene("res://scenes/cut_scenes/outro.tscn")
