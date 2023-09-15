extends CharacterBody2D

signal caught

var speed = 800
var player_chase = false
var player = null

func _ready():
	$NavigationAgent2D.avoidance_enabled

func _on_sightline_body_entered(body):
	player = body
	$NavigationAgent2D.set_target_position(player.global_position)
	$AnimatedSprite2D.play("chase")
	player_chase = true

func _on_sightline_body_exited(body):
	player = null
	$AnimatedSprite2D.play("default")
	player_chase = false
	
	

func _physics_process(delta):
	if player_chase == true:
		
		$NavigationAgent2D.set_target_position(player.global_position) #sets the player as its target position
		#updates every frame
		
		if not $NavigationAgent2D.is_navigation_finished(): #if the enemy hasn't reached the player
			var current_agent_position = get_global_position() #gets own position
			
			var next_path_position = $NavigationAgent2D.get_next_path_position() #gets next position to path to player
			velocity = (next_path_position - current_agent_position).normalized() * speed #calaculates vector to next position
			look_at(next_path_position)
			move_and_slide() #moves using calculated vector
		
