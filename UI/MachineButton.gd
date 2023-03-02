extends Button

export var id = 0

func _on_Button_pressed():
	GMManager.set_machine(id)
	print("a")
