extends Node

var score: int = 0 setget score_set, score_get

func score_set( addScore: int ) -> void:
	score += addScore

func score_get() -> int:
	return score

func clear_score() -> void:
	score = 0
	
func ranking() -> int:
	if score != 0:
		var ranking = score / 10
		return ranking
	return 0
	

func load_data():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		var data = { ranking(): score}
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
	var data = {ranking() : score}
	save_game.store_line(to_json(data))
	save_game.close()
