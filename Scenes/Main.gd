extends Node2D
# keep track of different resources types
const RESOURCETYPE = preload("res://scenes/ResourceType.gd")
onready var techTree = preload("res://Scenes/TechTree.tscn")
# using a .save file to save the techTree data and else
var save = Save.data
var techTreeIsOpen = false
var unlockable

func _ready():
	save = {
		"resources":{
		RESOURCETYPE.METAL: true,
		RESOURCETYPE.CARBON: false,
		RESOURCETYPE.WATER: false,
		RESOURCETYPE.MECHANICAL_ENERGY: false,
		RESOURCETYPE.ELECTRICAL_ENERGY: false,
		RESOURCETYPE.HYDROCARBON: false,
		RESOURCETYPE.STEM_CELL: false,
		RESOURCETYPE.BLOOD: false,
		RESOURCETYPE.TISSUE: false,
		RESOURCETYPE.HUMAN: false,
		RESOURCETYPE.ORGANS: false,
		RESOURCETYPE.HEART_PUMP: false,
		RESOURCETYPE.HUMAN_2:false,
		},
		"techTreeUnlocked":[true, false, false, false, false, false, false, false, false, false, false],
		"techTreeUnlockable":[true, false, false, false, false, false, false, false, false, false, false]
	}
	Save.data = save

func _unhandled_input(event):
	# Toggle tech tree menu
	if event.is_action_pressed("ToggleTechTree"):
		toggle_tech_tree()


func toggle_tech_tree():
	
	# if open, then close techTree
	if techTreeIsOpen:
		get_node("TechTree").queue_free()
	else:
		check_unlock()
		Save.data = save
		var tTree = techTree.instance()
		tTree.name = "TechTree"
		add_child(tTree)
		$TechTree.connect("unlocked_item", $MainCamera/UI/ConstructUI, "on_unlock")
		$TechTree.connect("update_floor", self, "on_update_floor")
	techTreeIsOpen = not techTreeIsOpen

func check_unlock():
	unlockable = save.techTreeUnlockable
	if save.resources[RESOURCETYPE.METAL]:
		unlockable[1] = true
	if save.resources[RESOURCETYPE.MECHANICAL_ENERGY]:
		unlockable[2] = true
	if save.resources[RESOURCETYPE.HYDROCARBON]:
		unlockable[3] = true
		unlockable[4] = true
	if save.resources[RESOURCETYPE.ELECTRICAL_ENERGY] and save.resources[RESOURCETYPE.STEM_CELL]:
		unlockable[5] = true
		unlockable[6] = true
	if save.resources[RESOURCETYPE.TISSUE] and save.resources[RESOURCETYPE.BLOOD]:
		unlockable[7] = true
	if save.resources[RESOURCETYPE.HUMAN]:
		unlockable[8] = true
		unlockable[9] = true
	if save.resources[RESOURCETYPE.ORGANS] and save.resources[RESOURCETYPE.HEART_PUMP]:
		unlockable[10] = true
	save.techTreeUnlockable = unlockable

func on_update_floor():
	$TilePlacer.level_up_floor()
