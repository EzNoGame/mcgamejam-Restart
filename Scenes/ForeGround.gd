extends CanvasLayer


onready var tilePlacer = get_node("../../TilePlacer")
onready var foreGround = $ColorRect
var buildMode
var BuildMode 

func _ready():
	BuildMode = GMManager.BuildMode

func _process(delta):
	buildMode = GMManager.buildMode
	if buildMode != BuildMode.NORMAL:
		visible = true
	
	else:
		visible = false
