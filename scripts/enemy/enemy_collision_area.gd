extends Area2D
class_name EnemyCollisionArea

@onready var enemy_stats: EnemyStats = get_node("../EnemyStats")
@onready var invencibility_timer: Timer = get_node("InvencibilityTimer")
@export var can_be_damaged = true

func toggle_monitoring():
	set_deferred('monitoring', !can_be_damaged)
	can_be_damaged = !can_be_damaged

func on_area_entered(area: Area2D) -> void:
	var damage = 0
	
	if area.name == 'FireballSpell':		
		damage = area.spell_damage

	elif area.name == 'PlayerAttackArea':
		var player_stats: PlayerStats = area.get_parent().get_node('PlayerStats')
		damage = player_stats.get_attack()
	
	if damage == 0: return
	enemy_stats.decrease_health(damage)
	print('Enemy was damaged = ' + str(damage))
	
	#toggle_monitoring()
	invencibility_timer.start(enemy_stats.invencibility_time)


func on_invencibility_timeout() -> void:
	toggle_monitoring()
