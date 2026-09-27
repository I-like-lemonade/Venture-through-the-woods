extends Area2D


@export var respawn_point: Marker2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.global_position = respawn_point.global_position
		body.velocity = Vector2.ZERO
