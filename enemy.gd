extends CharacterBody2D

signal caught

var speed = 400
var player_chase = false
var player = null

func _on_sightline_body_entered(body):
	player = body
	
	player_chase = true

func _on_sightline_body_exited(body):
	player = null
	player_chase = false

func _physics_process(delta):
	if player_chase == true:
		
		var direction = (player.position - position).normalized()
		look_at(player.global_position)
		set_velocity(direction * speed)
		move_and_slide()
		
		if velocity.x != 0 or velocity.y != 0:
			$AnimatedSprite2D.play("Moving")
		else:
			$AnimatedSprite2D.stop()

func _on_catch_body_entered(body):
	emit_signal("caught")
	print("hello")
