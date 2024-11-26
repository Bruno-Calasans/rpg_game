extends Enemy
class_name Crabby

func _ready() -> void:
	enemy_speed = 55
	enemy_exp = 5
	enemy_gravity = 350
	aproximity_threshold = 20
	default_floor_raycast_x_position = -16
