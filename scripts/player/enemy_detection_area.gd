extends Area2D

@onready var enemy: Enemy = get_parent()

func on_body_entered(body: Node2D) -> void:
	if body is Player: 
		enemy.player_ref = body
		print('Enemy sees player')
	

func on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player: 
		enemy.player_ref = null
		print('Player scapes out enemy sight')
	
