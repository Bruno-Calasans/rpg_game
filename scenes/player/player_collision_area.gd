extends Area2D
class_name PlayerCollisionArea

@onready var player_stats: PlayerStats = get_parent().get_node('PlayerStats')
@onready var invencibility_timer: Timer = get_node('InvencibilityTimer')

@export var invencibility_time = 2
@export var can_be_damaged = true

func toggle_monitoring():
	set_deferred('monitoring', !can_be_damaged)
	can_be_damaged = !can_be_damaged

func on_collision_area_entered(area: Area2D) -> void:
	var damage = 0
	
	# if it's a enemy attack
	if area.name == 'EnemyAttackArea':
		#var invencibility_timer: Timer = get_node('InvencibilityTimer')
		var enemy_stats: EnemyStats = area.get_parent().get_node('EnemyStats')
		damage = enemy_stats.damage
		
	if damage == 0: return
	player_stats.decrease_health(damage)
	print('Player was damaged = ' + str(damage))
	
	# it stops collision
	set_deferred('monitoring', false)
	invencibility_timer.start(invencibility_time)
		
func on_invencibility_timer_timeout() -> void:
	set_deferred('monitoring', true)
