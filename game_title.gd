extends Control


func _ready() -> void:
	$GameTitle.add_theme_font_size_override("font_size", 100)
	$PlayButton.pressed.connect(_on_play_button_pressed)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
