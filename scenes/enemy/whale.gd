extends Enemy
class_name Whale

func _ready() -> void:
	enemy_exp = 40
	enemy_speed = 55
	enemy_exp = 5
	enemy_gravity = 350
	aproximity_threshold = 10
	default_floor_raycast_x_position = -16
	var player_stats: PlayerStats = get_window().get_node('./Level/Player/PlayerStats')
	connect('enemy_is_dead', player_stats.on_enemy_is_dead)
