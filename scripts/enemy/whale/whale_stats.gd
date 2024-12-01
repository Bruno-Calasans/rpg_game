extends EnemyStats
class_name WhaleStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 4
	current_health = 8
	max_health = 8
	invencibility_time = 1
