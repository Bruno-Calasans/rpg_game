extends Node2D
class_name EnemyStats

signal enemy_health_update(health: int, current_health: int, type: String)

@onready var enemy: CharacterBody2D = get_parent()
@export var damage = 5
@export var current_health = 20
@export var max_health = 20
@export var invencibility_time = 1

func decrease_health(value: int):
	current_health -= value
	# play damage animation
	if current_health > 0:
		enemy.being_hit = true
		
	# play death animation
	if current_health <= 0:
		current_health = 0
		enemy.being_hit = true
		enemy.dead = true
	enemy_health_update.emit(value, current_health, 'decrease')
