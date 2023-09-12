extends CharacterBody2D

signal caught

var speed = 400
var player_chase = false
var player = null

func _ready():
	$NavigationAgent2D.avoidance_enabled

func _on_sightline_body_entered(body):
	player = body
	$NavigationAgent2D.set_target_position(player.global_position)
	player_chase = true

func _on_sightline_body_exited(body):
	player = null
	
	player_chase = false

func _physics_process(delta):
	if player_chase == true:
		
		$NavigationAgent2D.set_target_position(player.global_position)
		
		if not $NavigationAgent2D.is_navigation_finished(): #if the enemy hasn't reached the player
			var current_agent_position = get_global_position()
			
			var next_path_position = $NavigationAgent2D.get_next_path_position()
			velocity = (next_path_position - current_agent_position).normalized() * speed
			
			look_at(player.global_position)
			move_and_slide()
		
		#var direction = (player.position - position).normalized()
		#look_at(player.global_position)
		#set_velocity(direction * speed)
		#move_and_slide()
		
		if velocity.x != 0 or velocity.y != 0:
			$AnimatedSprite2D.play("Moving")
		else:
			$AnimatedSprite2D.stop()

func _on_catch_body_entered(body):
	emit_signal("caught")
	print("hello")
