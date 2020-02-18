extends Node2D

var pressed: bool = false


func _on_TextureButton_button_up() -> void:
	if !pressed:
		$Fade.play("fade_in")
		pressed = true

func _input(event: InputEvent) -> void:
	if event is InputEvent and event.is_pressed() and !pressed:
		$Fade.play("fade_in")
		pressed = true


func _on_Fade_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		get_tree().change_scene("res://src/Game.tscn")
