extends Node2D

var buildMode = GMManager.buildMode
var BuildMode = GMManager.BuildMode

var building_pipe = false

var grid: TileMap
var type: String

export(PackedScene) var floor_levels
var levels
var current_floor_level = 0

var root_machines = []

var last_pipe_pos = null

var has_been_run = {}
signal check_unlock

export var shift = 0


func _ready():
	
	# Init instance of objects
	grid = $Grid
	levels = floor_levels.instance()
	
	var white_hole = load("res://scenes/machines/WhiteHole.tscn").instance()
	white_hole.position = grid.map_to_world(Vector2(15, 8))
	add_child(white_hole)
	
	var metal_node = load("res://scenes/machines/MetalNode.tscn").instance()
	metal_node.position = grid.map_to_world(Vector2(15, 9))
	metal_node.grid_pos = Vector2(15,9)
	$MachineList.add_child(metal_node)
	root_machines.append(metal_node)
	
	levels = floor_levels.instance()
	set_floor_level(0)

func level_up_floor():
	current_floor_level += 1
	set_floor_level(current_floor_level)
	if current_floor_level == 1:
		var water_node = load("res://scenes/machines/WaterNode.tscn").instance()
		water_node.position = grid.map_to_world(Vector2(16, 8))
		water_node.grid_pos = Vector2(16,8)
		$MachineList.add_child(water_node)
		root_machines.append(water_node)
		
		var carbon_node = load("res://scenes/machines/CarbonNode.tscn").instance()
		carbon_node.position = grid.map_to_world(Vector2(15, 7))
		carbon_node.grid_pos = Vector2(15,7)
		$MachineList.add_child(carbon_node)
		root_machines.append(carbon_node)
		

func set_floor_level(lvl):
	for tile in levels.get_node("Floor" + str(current_floor_level)).get_used_cells():
		$Floor.set_cell(tile.x, tile.y, 0)
		

func _process(delta):
	
	buildMode = GMManager.buildMode
	material.set_shader_param("shift",shift)
	
	if buildMode != BuildMode.NORMAL:
		$Grid.visible = true
		for i in $MachineList.get_children():
			if not i in root_machines:
				i.get_node("Sprite").modulate = Color(1,1,1,0.3)
			i.get_node("IconList").visible = true
	else:
		$Grid.visible = false
		for i in $MachineList.get_children():
			if not i in root_machines:
				i.get_node("Sprite").modulate = Color(1,1,1,1)
			i.get_node("IconList").visible = false
	
	match(buildMode):
		BuildMode.MACHINEBUILD:
			$HUD._update_preview(grid.map_to_world(grid.world_to_map(get_global_mouse_position())) + Vector2(16, 16))
		
		BuildMode.PIPEBUILD:
			if Input.is_action_just_pressed("Accept"):
				var tile_pos = grid.world_to_map(get_global_mouse_position())
				var all_outputs = []
				for machine in $MachineList.get_children():
					all_outputs.append(machine.get_world_output())
				if $PipeSystem.get_pipe(tile_pos) or tile_pos in all_outputs:
					building_pipe = true
					
			if Input.is_action_pressed("Accept") and building_pipe:
				if last_pipe_pos == null:
					$PipeSystem.store_pipe(get_global_mouse_position(), true)
					last_pipe_pos = $PipeSystem.pipe_buffer[-1].position
				else:
					$PipeSystem.store_pipe(get_global_mouse_position(), false)
					
			if Input.is_action_just_released("Accept"):
				$PipeSystem.build_pipes()
				handle_object_update()
				building_pipe = false
				
		BuildMode.MACHINDESTORY:
			if Input.is_action_just_released("Accept"):
				var tile_pos = grid.world_to_map(get_global_mouse_position())
				for machine in $MachineList.get_children():
					if machine in root_machines:
						continue
					for tile in machine.get_world_tiles():
						if tile == tile_pos:
							machine.queue_free()
							$EffectSounds/Pickup.play()
							handle_object_update()
		BuildMode.PIPEDESTORY:
			if Input.is_action_pressed("Accept"):
				var tile_pos = grid.world_to_map(get_global_mouse_position())
				for pipe in $PipeSystem.pipes:
					if len(pipe.children) > 0 or pipe.position != tile_pos:
						continue
					if pipe.parent != null:
						pipe.parent.children.erase(pipe)
					grid.set_cellv(pipe.position, -1)
					$PipeSystem.pipes.erase(pipe)
					$EffectSounds/Pickup.play()
					handle_object_update()

func _unhandled_input(event):
	if event.is_action_released("Cancel") and buildMode != BuildMode.NORMAL:
		cancel_build_mode()
	if event.is_action_released("Accept") and buildMode == BuildMode.MACHINEBUILD and GMManager.machineType != null:
		register_to_build()

func handle_object_update():
	for machine in $MachineList.get_children():
		machine.functioning = machine in root_machines
		for key in machine.inputs.keys():
			machine.inputs[key] = false
	for root in root_machines:
		if $PipeSystem.get_pipe(root.get_world_output()) != null:
			dfs($PipeSystem.get_pipe(root.get_world_output()), root.output_type)
	for machine in $MachineList.get_children():
		if machine.get_node("AnimationPlayer") and not machine.functioning:
			machine.get_node("AnimationPlayer").stop()
	get_parent().check_unlock()

func dfs(pipe,type):
	var is_functioning = true
	for machine in $MachineList.get_children():
		for i in machine.inputs_positions.keys():
			if machine.get_world_inputs()[i] == pipe.position and i == type:
				machine.inputs[i] = true
				for j in machine.inputs.values():
					if j == false:
						is_functioning = false
						break
				if is_functioning:
					machine.functioning = true
					if machine.get_node("AnimationPlayer"):
						machine.get_node("AnimationPlayer").play("Functioning")
						var data = Save.data
						if not data.resources[machine.output_type]:
							data.resources[machine.output_type] = true
							Save.data = data
					if $PipeSystem.get_pipe(machine.get_world_output()) != null:
						dfs($PipeSystem.get_pipe(machine.get_world_output()), machine.output_type)
	if len(pipe.children) == 0:
		return
	else:
		for i in pipe.children:
			dfs(i,type)

func register_to_build():
	var machine = GMManager.MachineList[GMManager.machineType].instance()
	machine.grid_pos = grid.world_to_map(get_global_mouse_position())
	machine.position = grid.map_to_world(machine.grid_pos)

	var occupied = machine.get_world_tiles()

	for tile in occupied:
		if not (tile in $Floor.get_used_cells()):
			return
		for temp in $MachineList.get_children():
			if tile in temp.get_world_tiles():
				return

	$MachineList.add_child(machine)
	machine.use_parent_material = true
	handle_object_update()
	$EffectSounds/Building_Place.play()
	cancel_build_mode()
	
func cancel_build_mode():
	$Floor.hide_grid()
	if buildMode == BuildMode.MACHINEBUILD and $HUD.get_child_count() != 0:
		$HUD.get_child(0).queue_free()
	buildMode = BuildMode.NORMAL
	GMManager.buildMode = buildMode
	GMManager.reset_machine()
