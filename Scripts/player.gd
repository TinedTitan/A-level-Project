extends CharacterBody2D

var dash_available = true #whether the player can dash or not
var animation_lock = false #while true, locks other animations from playing. This prevents weird animation-
#clipping and stops animation cancelling on certain animations

@export var speed = 800
@export var hp = 1000

func _ready():
	$AnimatedSprite2D.play("idle") #sets the animation to idle state

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
	
	if animation_lock == false: #checks if the player is in a locked animation
		
		if Input.is_action_just_pressed("MB1"):
			animation_lock = true #locks other animations
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("Slash")
			$Attacking.start()
		
		if Input.is_action_just_pressed("MB2"):
			animation_lock = true
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("Thrust")
			$HeavyAttacking.start()
			
	if dash_available == true: #checks if the player can dash
		if Input.is_action_just_pressed("shift"):
			speed = 5000
			$"Dash Active".start() #starts the timer of the dash being active
			print("Dash")
			$AnimatedSprite2D.stop() #stops any other ongoing animation and begins dash - enables dash-cancel
			$AnimatedSprite2D.play("dash")
			dash_available = false
		
		
#runs every physics update (once a frame)
func _physics_process(_delta): #called every frame
	set_velocity(Vector2.ZERO)
	movement_input() #runs player input function
	move_and_slide() #uses inbuilt move_and_slide function to move the player based on velocity
	
	if velocity.x != 0 or velocity.y != 0:
		if animation_lock == false:
			$AnimatedSprite2D.play("Moving")
	elif animation_lock != true:
		$AnimatedSprite2D.play("idle")
	
	look_at(get_global_mouse_position())

func _on_dash_active_timeout(): #when the active dash has run out, returns speed to normal and begins cooldown
	speed = 800
	$"Dash Cooldown".start()
	animation_lock = false
	print("Active Timeout")

func _on_dash_cooldown_timeout():
	dash_available = true
	print("Cooldown Timeout")

func _on_attacking_timeout():
	animation_lock = false

func _on_heavy_attacking_timeout():
	animation_lock = false
