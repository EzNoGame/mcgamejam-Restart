extends TextureButton

export var id = 0

func _on_Button_pressed():
	pass


func _on_TextureButton_pressed():
	GMManager.set_machine(id)
	print("a")
