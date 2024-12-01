extends Enemy
class_name PinkStar

func _ready() -> void:
	enemy_speed = 70
	enemy_exp = 10
	enemy_gravity = 250
	aproximity_threshold = 10
	default_floor_raycast_x_position = -16
	var player_stats: PlayerStats = get_window().get_node('./Level/Player/PlayerStats')
	connect('enemy_is_dead', player_stats.on_enemy_is_dead)
