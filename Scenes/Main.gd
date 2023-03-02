extends Node2D
# keep track of different resources types
const RESOURCETYPE = preload("res://scenes/ResourceType.gd")
onready var techTree = preload("res://Scenes/TechTree.tscn")
# using a .save file to save the techTree data and else
var save = Save.data
var techTreeIsOpen = false
var unlocked
var gameMode
enum GameMode{
	NORMAL,
	PIPE_BUILD,
	MACHINE_BUILD,
	PIPE_DESTORY,
	MACHINE_DESTORY,
	FREEZE
}

func _ready():
	save = {
		"resources":{
		RESOURCETYPE.METAL: false,
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
		},
		"techTreeUnlocked":[true, false, false, true, false, false, false, false, false, false, false],
		"techTreeUnlockable":[true, false, false, true, false, false, false, false, false, false, false]
	}
	Save.data = save
	Save.save_data()

func _process(delta):
	pass


func _unhandled_input(event):
	# Toggle tech tree menu
	if event.is_action_pressed("ToggleTechTree"):
		toggle_tech_tree()


func toggle_tech_tree():
	
	# if open, then close techTree
	if techTreeIsOpen:
		Save.save_data()
		get_node("TechTree").queue_free()
	else:
		Save.save_data()
		var tTree = techTree.instance()
		tTree.name = "TechTree"
		add_child(tTree)
	techTreeIsOpen = not techTreeIsOpen

func check_unlock():
	# check each tech is open or not
	# REFACTOR: can use a json/save file to keep track
	unlocked = save.techTreeUnlocked
	if save.resources[RESOURCETYPE.METAL]:
		unlocked[1] = true
		unlocked[5] = true
	if save.resources[RESOURCETYPE.HYDROCARBON]:
		unlocked[4] = true
		unlocked[6] = true
		$BackgroundSounds.insanity_stage = 2
	if save.resources[RESOURCETYPE.STEM_CELL]:
		unlocked[7] = true
		unlocked[8] = true
		$BackgroundSounds.insanity_stage = 3
	if save.resources[RESOURCETYPE.BLOOD]:
		unlocked[9] = true
		$BackgroundSounds.insanity_stage = 4
