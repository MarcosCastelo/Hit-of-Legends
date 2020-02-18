extends Node2D

func _on_Restart_button_down() -> void:
	Stats.clear_score()
	get_tree().change_scene("res://src/Game.tscn")


func _ready() -> void:
	$Score/Pontuation.text = "Score: " + str(Stats.score_get())
	$Score/Raking.texture = Stats.ranking()
	$Score/Raking.scale = Vector2(0.6, 0.6)
	
	var data = Stats.load_data()
	if data.values()[0] < Stats.score:
		$HighScore/Pontuation.text = "New Highscore! "
		$HighScore/Ranking.texture = Stats.ranking()
		Stats.save_data()
	else:
		$HighScore/Pontuation.text = "Highscore: " + str(data.values()[0])
		$HighScore/Ranking.texture = Stats.RANKING[int(data.keys()[0])]


func _on_Quit_button_down() -> void:
	get_tree().quit()
