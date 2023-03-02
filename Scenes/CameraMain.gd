extends Camera2D

var Velocity = Vector2()
var speed = 300
var zoomFactor = 1.05
var zoomMax = 2.0
var zoomMin = 0.3

func _physics_process(delta):
	free_camera_movement(delta)
	free_camera_zoom(delta)
	
func free_camera_movement(delta):
	# Camera controll
	# press WASD to move around camera
	# ADD: also add mouse controll camera
	Velocity = Vector2.ZERO
	if Input.is_action_pressed("Camera_Up"):
		Velocity.y-=1
	if Input.is_action_pressed("Camera_Down"):
		Velocity.y+=1
	if Input.is_action_pressed("Camera_Right"):
		Velocity.x+=1
	if Input.is_action_pressed("Camera_Left"):
		Velocity.x-=1			
	position += Velocity*speed*delta

func free_camera_zoom(delta):
	# zoom in
	if Input.is_action_just_released("Camera_Zoom_In"):
		if get_zoom().x > zoomMin:
			set_zoom(get_zoom()/zoomFactor)
	elif Input.is_action_just_released("Camera_Zoom_Out"):
		if get_zoom().x < zoomMax:
			set_zoom(get_zoom()*zoomFactor)
