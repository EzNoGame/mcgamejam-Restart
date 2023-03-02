extends Node2D

var rng = RandomNumberGenerator.new()

var time_since_last_sound = 0.0
var length_of_last_sound = 0.0 
var buffer_between_sounds = 0.0
var time_since_last_highlight = 0.0
var insanity_stage = 1
var pick = 0

func _ready():
	pass
	
func _process(delta):
	time_since_last_sound += delta
	if insanity_stage == 1:
		if time_since_last_sound >= buffer_between_sounds + length_of_last_sound:
			time_since_last_sound = 0
			pick = rng.randi_range(0, 1)
			buffer_between_sounds = rng.randf_range(10.0, 30.0)
			if pick == 0:
				$Tromboner1.play()
				length_of_last_sound = 19.6
			else:
				$Tromboner2.play()
				length_of_last_sound = 11.4
		
	elif insanity_stage == 2:
		if time_since_last_sound >= buffer_between_sounds + length_of_last_sound:
			time_since_last_sound = 0
			pick = rng.randi_range(0, 3)
			buffer_between_sounds = rng.randf_range(5.0, 15.0)
			if pick == 0:
				$Tromboner1.play()
				length_of_last_sound = 19.6
			if pick == 1:
				$Tromboner2.play()
				length_of_last_sound = 11.4
			if pick == 2:
				$Whisper1.play()
				length_of_last_sound = 5.8
			else:
				$Whisper2.play()
				length_of_last_sound = 7.2
	elif insanity_stage == 3:
		if time_since_last_sound >= buffer_between_sounds + length_of_last_sound:
			time_since_last_sound = 0
			pick = rng.randi_range(0, 6)
			buffer_between_sounds = rng.randf_range(0, 10.0)
			if pick == 0:
				$Tromboner1.play()
				length_of_last_sound = 19.6
			if pick == 1:
				$Tromboner2.play()
				length_of_last_sound = 11.4
			if pick == 2:
				$Whisper1.play()
				length_of_last_sound = 5.8
			if pick == 3:
				$Whisper2.play()
				length_of_last_sound = 7.2
			if pick == 4:
				$Whining.play()
				length_of_last_sound = 8.5
			if pick == 5:
				$White_Chirst.play()
				length_of_last_sound = 14.6
			else:
				$Whinge.play()
				length_of_last_sound = 7.6
	elif insanity_stage == 4:
		if time_since_last_sound >= buffer_between_sounds + length_of_last_sound:
			time_since_last_sound = 0
			pick = rng.randi_range(0, 9)
			buffer_between_sounds = rng.randf_range(-5.0, 5.0)
			if pick == 0:
				$Tromboner1.play()
				length_of_last_sound = 19.6
			if pick == 1:
				$Tromboner2.play()
				length_of_last_sound = 11.4
			if pick == 2:
				$Whisper1.play()
				length_of_last_sound = 5.8
			if pick == 3:
				$Whisper2.play()
				length_of_last_sound = 7.2
			if pick == 4:
				$Whining.play()
				length_of_last_sound = 8.5
			if pick == 5:
				$White_Chirst.play()
				length_of_last_sound = 14.6
			if pick == 6:
				$Whinge.play()
				length_of_last_sound = 7.6
			if pick == 7:
				$Burd.play()
				length_of_last_sound = 3.1
			if pick == 8:
				$Laughing.play()
				length_of_last_sound = 11.2
			else:
				$Gasping.play()
				length_of_last_sound = 7.1
	else:
		if time_since_last_sound >= length_of_last_sound:
			time_since_last_sound = 0
			pick = rng.randi_range(0, 3)
			if pick == 0:
				$Tromboner1.play()
				length_of_last_sound = 19.6
			if pick == 1:
				$Tromboner2.play()
				length_of_last_sound = 11.4
			if pick == 2:
				$Whinge.play()
				length_of_last_sound = 7.6
			else:
				$Static.play()
				length_of_last_sound = 30.4
		time_since_last_highlight += delta
		if time_since_last_highlight >= buffer_between_sounds:
			time_since_last_highlight = 0
			buffer_between_sounds = rng.randf_range(0, 10.0)
			pick = rng.randi_range(0, 6)
			if pick == 0:
				$Whisper1.play()
				length_of_last_sound = 5.8
			if pick == 1:
				$Whisper2.play()
				length_of_last_sound = 7.2
			if pick == 2:
				$Whining.play()
				length_of_last_sound = 8.5
			if pick == 3:
				$White_Chirst.play()
				length_of_last_sound = 14.6
			if pick == 4:
				$Burd.play()
				length_of_last_sound = 3.1
			if pick == 5:
				$Laughing.play()
				length_of_last_sound = 11.2
			else:
				$Gasping.play()
				length_of_last_sound = 7.1
