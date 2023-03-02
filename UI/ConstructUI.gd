extends Control

var BuildMode = GMManager.BuildMode
var buildMode

func _process(delta):
	buildMode = GMManager.buildMode
	if buildMode == BuildMode.MACHINEBUILD:
		var rect = Rect2(rect_position, $PopupPanel.rect_min_size)
		$PopupPanel.popup(rect)
		print(rect)
	else:
		$PopupPanel.visible = false
