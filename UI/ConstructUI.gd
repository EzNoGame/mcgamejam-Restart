extends Control

var BuildMode = GMManager.BuildMode
var buildMode

func _process(delta):
	buildMode = GMManager.buildMode
	if buildMode == BuildMode.MACHINEBUILD:
		visible = true
	else:
		visible = false
