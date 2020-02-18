extends Node


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

var score: int = 0 setget score_set, score_get

func score_set( addScore: int ) -> void:
	score += addScore

func score_get() -> int:
	return score

func clear_score() -> void:
	score = 0
	
func ranking() -> Sprite:
	var ranking: int = 0
	if score != 0:
		ranking = score / 10
	return RANKING[ranking]
	

func load_data():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		var ranking = score % 10 if score > 0 else 0
		var data = {ranking : score}
		save_game.open("user://savegame.save", File.WRITE)
		save_game.store_line(to_json(data))
		save_game.close()
		return data
	save_game.open("user://savegame.save", File.READ)
	var data = parse_json(save_game.get_line())
	save_game.close()
	return data


func save_data():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var ranking = score % 10 if score > 0 else 0
	var data = {ranking : score}
	save_game.store_line(to_json(data))
	save_game.close()
