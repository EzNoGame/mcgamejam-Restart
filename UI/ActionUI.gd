extends Control

func _ready():
	Save.load_data()
	var unlocked
#	$HBoxContainer/Back.hide()
	
#	if unlocked != null:
#		for i in unlocked.size():
#			if unlocked[i]:
#				var node = find_node("Machine " + str(i))
#				if node == null:
#					continue
#				node.set_disabled(false)
#				match i:
#					3:
#						node.set_tooltip("Perpetual Motion Machine")
#					5:
#						node.set_tooltip("Hydrocarbon Generator")
#					4:
#						node.set_tooltip("The Dynamo")
#					7:
#						node.set_tooltip("Blood Blender")
#					8:
#						node.set_tooltip("Tissue Box")
#					6:
#						node.set_tooltip("Stem Cell Generator")
#					9:
#						node.set_tooltip("Human")


func _on_Build_Pipe_pressed():
	if GMManager.buildMode != GMManager.BuildMode.PIPEBUILD:
		GMManager.buildMode = GMManager.BuildMode.PIPEBUILD
	else:
		GMManager.buildMode = GMManager.BuildMode.NORMAL


func _on_Build_Machine_pressed():
	if GMManager.buildMode != GMManager.BuildMode.MACHINEBUILD:
		GMManager.buildMode = GMManager.BuildMode.MACHINEBUILD
	else:
		GMManager.buildMode = GMManager.BuildMode.NORMAL


func _on_Destroy_Pipe_pressed():
	if GMManager.buildMode != GMManager.BuildMode.PIPEDESTORY:
		GMManager.buildMode = GMManager.BuildMode.PIPEDESTORY
	else:
		GMManager.buildMode = GMManager.BuildMode.NORMAL


func _on_Destroy_Machine_pressed():
	if GMManager.buildMode != GMManager.BuildMode.MACHINDESTORY:
		GMManager.buildMode = GMManager.BuildMode.MACHINDESTORY
	else:
		GMManager.buildMode = GMManager.BuildMode.NORMAL
