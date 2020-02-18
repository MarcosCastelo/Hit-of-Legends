extends Node2D

onready var bronze = preload("res://assets/trophys/Cup-bronze-icon.png")
onready var silver = preload("res://assets/trophys/Cup-silver-icon.png")
onready var gold = preload("res://assets/trophys/Cup-gold-icon.png")
onready var plat = preload("res://assets/trophys/Cup-plat-icon.png")

onready var RANKING = {
	0 : bronze,
	1 : silver,
	2 : gold,
	3 : plat
}


func _on_Restart_button_down() -> void:
	Stats.clear_score()
	get_tree().change_scene("res://src/Game.tscn")


func _ready() -> void:
	$Score/Pontuation.text = "Score: " + str(Stats.score_get())
	$Score/Raking.texture = RANKING[Stats.ranking()]
	print(RANKING[Stats.ranking()])
	$Score/Raking.scale = Vector2(0.6, 0.6)
	
	var data = Stats.load_data()
	if data.values()[0] < Stats.score:
		$HighScore/Pontuation.text = "New Highscore! "
		$HighScore/Ranking.texture = RANKING[Stats.ranking()]
		Stats.save_data()
	else:
		$HighScore/Pontuation.text = "Highscore: " + str(data.values()[0])
		$HighScore/Ranking.texture = RANKING[int(data.keys()[0])]


func _on_Quit_button_down() -> void:
	get_tree().quit()
