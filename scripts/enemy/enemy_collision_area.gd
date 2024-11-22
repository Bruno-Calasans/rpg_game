extends Area2D
class_name EnemyCollisionArea

@onready var enemy_stats: EnemyStats = get_node("../EnemyStats")
@export var invencibility_timer = 1

func on_area_entered(area: Area2D) -> void:
	if area.name == 'PlayerAttackArea' and area.get_parent() is Player:
		print('before health:  ' + str(enemy_stats.current_health))
		var player_stats: PlayerStats = area.get_parent().get_node('Stats')
		enemy_stats.decrease_health(player_stats.get_attack())
		print('after health:  ' + str(enemy_stats.current_health))
		
