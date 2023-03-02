extends TileMap
class_name Floor

var drawing_grid: bool
var color: Color

func _ready():
	drawing_grid = false

func show_grid(grid_color: Color):
	color = grid_color
	drawing_grid = true

func hide_grid():
	drawing_grid = false
