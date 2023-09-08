extends CharacterBody2D

@export var speed = 500

func _ready():
	$Label.hide()

func player_input():
	var vector = Vector2.ZERO #sets the player's velocity to 0,0
	if Input.is_action_pressed("move_right"): #simple inputs to set player velocity
		vector.x += 1
	if Input.is_action_pressed("move_left"):
		vector.x -= 1
	if Input.is_action_pressed("move_down"):
		vector.y += 1
	if Input.is_action_pressed("move_up"): #moving up sets the y velocity to negative and vice versa
		vector.y -= 1 #this is because the postive y axis is flipped
		
	vector = vector.normalized() * speed #scales the magnitude to 1 - keeps speed the same when moving diagonally
	if vector.length() > 0: #if the magnitude of the vector is greater than 0
		set_velocity(vector)
	
func _physics_process(delta): #called every frame
	set_velocity(Vector2.ZERO)
	player_input() #runs player input function
	move_and_slide() #uses inbuilt move_and_slide function to move the player based on velocity


