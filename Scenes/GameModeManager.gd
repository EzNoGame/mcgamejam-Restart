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
