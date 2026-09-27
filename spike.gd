extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.global_position = Vector2(0, 0)
		body.velocity = Vector2.ZERO
