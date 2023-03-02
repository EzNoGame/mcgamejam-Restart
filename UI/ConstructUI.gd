extends Control

var BuildMode = GMManager.BuildMode
var buildMode

func _process(delta):
	buildMode = GMManager.buildMode
	if buildMode == BuildMode.MACHINEBUILD:
		visible = true
	else:
		visible = false

func on_unlock():
	print("unlocked")
	for button in $GridContainer.get_children():
		if Save.data["techTreeUnlocked"][button.id+1]:
			button.disabled = false
		
