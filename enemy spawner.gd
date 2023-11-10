extends Node

var enemycount = 0
var enemy_group = ""
var spawnqueue = 0
var enemy = ""
var timerlock = false

func _ready():
	enemy_group = get_tree().get_nodes_in_group("enemy")
	print(enemy_group)
	var enemy = load("res://enemy.tscn")
	randomize()

func _process(delta):
	enemy_group = get_tree().get_nodes_in_group("enemy")
	enemycount = len(enemy_group)
	print(enemycount)
	
	if enemycount < 8:
		if timerlock == false:
			$Timer.start(randi() % 10)
			timerlock = true
			print("time start")
		

func _on_timer_timeout():
	var enemigo = enemy.instance()
	add_child(enemigo)
	timerlock = false
	print("Spawn")
