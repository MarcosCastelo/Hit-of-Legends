extends Node2D

func _ready() -> void:
	set_physics_process(true)


func _physics_process(delta: float) -> void:
	$Score.text = "Score: " + str(Stats.score_get())
	
	if Stats.score > 0 and Stats.score % 10 == 0:
		$Ranking.texture = Stats.ranking()
		$Ranking.scale = Vector2(0.3, 0.3)
		$Ranking/AnimationPlayer.play("trophy_appear")
	
