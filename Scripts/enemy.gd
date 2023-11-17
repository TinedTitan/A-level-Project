extends CharacterBody2D

@export var hp = 25
var speed = 880
signal kaboom
var player_chase = false
var player = null
var animlock = false
var die = false
var me = self

func _ready():
	$AnimatedSprite2D.play("default")

func _on_sightline_body_entered(body):
	player = body
	$NavigationAgent2D.set_target_position(player.global_position)
	if not animlock == true:
		$AnimatedSprite2D.play("chase")
	player_chase = true

func _on_sightline_body_exited(body):
	player = null
	if not animlock == true:
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

func _on_bad_zone_body_entered(body):
		print("click")
		speed = 0
		player_chase = false
		if animlock == false:
			$AnimatedSprite2D.play("pre_explode")
			$"Big boom".start()

func _on_big_boom_timeout():
	if not animlock == true:
		$AnimatedSprite2D.play("explode")
		animlock = true
	var deadmen = $Explosion_radius.get_overlapping_bodies()
	print("boom")
	print(deadmen)
	die = true

func _process(delta):
	if die == true:
		if $AnimatedSprite2D.is_playing() == false:
			queue_free()


func _on_tree_exiting():
	remove_from_group("enemy")
