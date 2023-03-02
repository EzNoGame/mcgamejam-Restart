extends Node2D

var pipe_roots : Array
var pipes : Array
var pipe_buffer: Array = []

var grid: TileMap
var preview : TileMap
var Pipe = preload("Pipe.gd")

func _ready():
	grid = get_node("../Grid")
	preview = get_node('../PipePreview')

func _process(delta):
	for pipe in pipes:
		var tile_id = get_pipe_bitmask(pipe)
		grid.set_cellv(pipe.position, tile_id)

func store_pipe(pos : Vector2, is_root=false):
	var tile_pos = grid.world_to_map(pos)
	# TO FIX: Pipe gaps when moving mouse too fast
	if len(pipe_buffer) > 1:
		var pipe_direction = pipe_buffer[1].position - pipe_buffer[0].position
		pipe_direction = pipe_direction.normalized()
		if pipe_direction.x != 0: # Horizontal
			tile_pos = Vector2(tile_pos.x, pipe_buffer[0].position.y)
		else:
			tile_pos = Vector2(pipe_buffer[0].position.x, tile_pos.y)
		
		var diff = tile_pos - pipe_buffer[-1].position
		var dist = diff.length()
		if dist > 1 and diff.normalized().dot(pipe_direction) != -1:
			for i in range(1, dist):
				var pipe = Pipe.new(pipe_buffer[-1].position + i * pipe_direction)
				pipe_buffer.append(pipe)
				preview.set_cellv(tile_pos, 0)
	
	for pipe in pipe_buffer:
		if pipe.position == tile_pos:
			return
			
	var pipe = Pipe.new(tile_pos)
		
	pipe_buffer.append(pipe)
	get_parent().get_node("EffectSounds/Pipe_Node_Place").play()
	
	# Set greyed out version of pipe (preview)
	preview.set_cellv(tile_pos, 0)
	
func build_pipes():
	if not pipe_buffer:
		return
		
	var collision = false
	var start = 1 if get_pipe(pipe_buffer[0].position) else 0
	
	for i in range(start, len(pipe_buffer)):
		if get_pipe(pipe_buffer[i].position):
			collision = true
			break 
	for i in range(start, len(pipe_buffer)):
		if not collision:
			if i==0:
				pipe_buffer[i].parent = null
			elif i==1:
				pipe_buffer[i].parent = get_pipe(pipe_buffer[0].position)
			else:
				pipe_buffer[i].parent = pipe_buffer[i-1]
			pipes.append(pipe_buffer[i])
			#print(pipe_buffer[i].parent)
			if pipe_buffer[i].parent != null:
				get_pipe(pipe_buffer[i].parent.position).children.append(pipe_buffer[i])
				
	pipe_buffer = []
	get_parent().get_node("EffectSounds/Pipe_Place").play()
	preview.clear()

func get_pipe(pos: Vector2) -> Pipe:
	for pipe in pipes:
		if pipe.position == pos:
			return pipe
	return null

func get_pipe_bitmask(pipe: Pipe) -> int:
	var bitmask = 0
	
	var surrounding = []
	for child in pipe.children:
		surrounding.append(pipe.position - child.position)
	if pipe.parent:
		surrounding.append(pipe.position - pipe.parent.position)
	for adjacent in surrounding:
		match adjacent:
			Vector2(0, 1): # Up
				bitmask = bitmask ^ (1 << 0)
			Vector2(-1, 0):
				bitmask = bitmask ^ (1 << 1)
			Vector2(0, -1):
				bitmask = bitmask ^ (1 << 2)
			Vector2(1, 0):
				bitmask = bitmask ^ (1 << 3)
	return bitmask
	
	
