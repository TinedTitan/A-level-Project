extends CharacterBody2D
var dash = true
var animlock = false
#
@export var speed = 800

#HIDES THE LABEL UPON LOADING IN
func _ready():
	$Label.hide()

#---------------------PLAYER INPUT---------------------------------------
func movement_input():

	var vector = Vector2.ZERO #sets the player's velocity to 0,0
	if Input.is_action_pressed("move_right"): #simple inputs to set player velocity
		vector.x += 1
	if Input.is_action_pressed("move_left"):
		vector.x -= 1
	if Input.is_action_pressed("move_down"):
		vector.y += 1
	if Input.is_action_pressed("move_up"): #moving up sets the y velocity to negative and vice versa
		vector.y -= 1 #this is because the postive y axis is flipped
#--------------------------VECTOR MATH---------------------------------------------------------
	vector = vector.normalized() * speed #scales the magnitude to 1 - keeps speed the same when moving diagonally
	if vector.length() > 0: #if the magnitude of the vector is greater than 0
		set_velocity(vector)
#
func _process(_delta):
	
	if animlock == false:
		if Input.is_action_just_pressed("MB1"):
			animlock = true
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("Slash")
			while not $AnimatedSprite2D.is_playing():
				animlock = false
				
		if dash == true:
			if Input.is_action_just_pressed("shift"):
				animlock = true
				speed = 5000
				$"Dash Active".start()
				print("Dash")
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.play("dash")
				dash = false
		
		
#runs every physics update (once a frame)
func _physics_process(_delta): #called every frame
	set_velocity(Vector2.ZERO)
	movement_input() #runs player input function
	move_and_slide() #uses inbuilt move_and_slide function to move the player based on velocity
	
	if velocity.x != 0 or velocity.y != 0:
		if animlock == false:
			$AnimatedSprite2D.play("Moving")
	else:
		$AnimatedSprite2D.pause()
	
	look_at(get_global_mouse_position())

func _on_enemy_caught():
	$Label.show()


func _on_dash_active_timeout():
	speed = 800
	$"Dash Cooldown".start()
	animlock = false
	print("Active Timeout")


func _on_dash_cooldown_timeout():
	dash = true
	print("Cooldown Timeout")
