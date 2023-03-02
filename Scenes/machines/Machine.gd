extends Node

class_name Machine

const ResourceType = preload("res://scenes/ResourceType.gd")

var functioning = false
var grid_pos = Vector2.ZERO
var shape = []
var inputs_positions = {}
var inputs = {}
var output_position
var output_type: int

func _ready():
	pass

func toggle_script_off():
	set_process(false)
	
func toggle_script_on():
	set_process(true)

func _process(delta):
	pass
	
func get_world_tiles():
	var occupied = []
	for tile in shape:
		occupied.append(tile + grid_pos)
	return occupied

func get_world_inputs():
	var world_inputs = {}
	for key in inputs_positions.keys():
		world_inputs[key] = inputs_positions[key] + grid_pos
	return world_inputs

func get_world_output():
	if output_position == null:
		return null
	return output_position + grid_pos
