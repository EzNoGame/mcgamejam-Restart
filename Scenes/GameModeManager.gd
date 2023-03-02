extends Node

enum BuildMode {
	NORMAL,
	PIPEBUILD,
	MACHINEBUILD,
	PIPEDESTORY,
	MACHINDESTORY,
	FREEZE
}
var buildMode = BuildMode.NORMAL

var machineType = null

func reset_machine():
	machineType = null

func set_machine(id: int):
	machineType = id
