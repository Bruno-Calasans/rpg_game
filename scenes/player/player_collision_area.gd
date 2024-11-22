extends Area2D
class_name PlayerCollisionArea

@onready var invencibility_timer: Timer = get_node('InvencibilityTimer')
@export var invencibility_time = 1

func on_invencibility_timer_timeout() -> void:
	set_deferred('monitoring', true)

func on_collision_area_entered(area: Area2D) -> void:
	# if it's a enemy attack
	if area.name == 'EnemyAttackArea' and area.get_parent() is Enemy:
		var player_stats: PlayerStats = get_parent().get_node('PlayerStats')
		var enemy_stats: EnemyStats = area.get_parent().get_node('EnemyStats')
		var enemy_collision_area: EnemyCollisionArea = area.get_node('../EnemyCollisionArea')
		
		player_stats.decrease_health(enemy_stats.damage)
		
		# it stops collision
		set_deferred('monitoring', false)
		invencibility_timer.start(enemy_collision_area.invencibility_time)
