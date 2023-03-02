extends CanvasLayer

var buttons = []
var save
var unlocked
var unlockable

func _ready():
	# get data from save filet
	save = Save.data
	unlocked = save.techTreeUnlocked
	unlockable = save.techTreeUnlockable
	
	for i in unlocked.size():
		var node = find_node(str(i))
		if node == null:
			buttons.append(node)
			continue
		buttons.append(node)
		node.connect("pressed", self, 'unlock', [node])
		
	update_unlocks()

func unlock(node):
	var id = int(node.name)
	if unlockable[id]:
		unlocked[id] = true
		save.techTreeUnlocked = unlocked
		Save.data = save
		update_unlocks()

func update_unlocks():
		
	for i in range(len(buttons)):
		var button = buttons[i]
		if unlocked[i]:
			button.set_modulate(Color(1,1,1,1))
			button.set_tooltip(button.tooltip_desc + "\n\nYou have unlocked this tech.")
			button.set_disabled(false)
		elif unlockable[i]:
			button.set_modulate(Color(0.5, 0.5, 0.5, 0.5))
			button.set_tooltip(button.tooltip_desc)
			button.set_disabled(false)
