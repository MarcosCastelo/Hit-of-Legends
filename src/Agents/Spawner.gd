extends Node2D

onready var timer: Timer = $Timer
onready var enemy_scene: = preload("res://src/Agents/CharacterFollow.tscn")

export var min_time: float = 2
export var max_time: float = 6

var random_generate = RandomNumberGenerator.new()


func _ready():
	timer.wait_time = get_random_time()
	timer.start()


func _on_Timer_timeout() -> void:
	var enemy = enemy_scene.instance()
	enemy.position = $Position2D.global_position
	get_parent().add_child(enemy)
	timer.wait_time = get_random_time()
	timer.start()


func get_random_time():
	random_generate.randomize()
	var random_time = random_generate.randf_range(min_time, max_time)
	return random_time
