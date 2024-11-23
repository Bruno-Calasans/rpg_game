extends Area2D
class_name ItemInterationArea

@onready var item: Item = get_parent()

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		item.player_ref = body
		print('player can interact')

func on_body_exited(body: Node2D) -> void:
	if body is Player:
		item.player_ref = null
		print('player cant interact')
