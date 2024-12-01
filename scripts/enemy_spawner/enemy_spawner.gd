extends Node2D
class_name EnemySpawner

@onready var spawn_cooldown_timer: Timer = get_node("SpawnCooldown")

@export var enemy_path_scene: String = ''
@export var spawn_cooldown_time = 2
@export var min_spawn_chance = 1
@export var max_spawn_chance = 100
@export var enemy_y_offset = -10
@export var right_x_offset = 100
@export var left_x_offset = -100
@export var can_respawn = false
@export var max_enemy_amount = 2

var enemy_amount = 0

func _ready() -> void:
	randomize()
	spawn_enemy()

func spawn_enemy():
	enemy_amount += 1
	if  enemy_amount >= max_enemy_amount: 
		enemy_amount = max_enemy_amount
	
	var spawn_chance = randi_range(1, 100)
	if spawn_chance >= min_spawn_chance and spawn_chance <= max_spawn_chance:
		var enemy = load(enemy_path_scene).instantiate() as Enemy
		enemy.global_position = spawn_position(enemy_y_offset)
		enemy.connect('enemy_is_dead', on_enemy_is_dead)
		call_deferred('add_child', enemy)
		print('Enemy spawned = ' + enemy.name)

	
	# cooldown spawn after spawn a enemy
	if enemy_amount < max_enemy_amount:
		spawn_cooldown_timer.start(spawn_cooldown_time)
	
# reduce enemy amount and cooldown the spawn
func on_enemy_is_dead():
	enemy_amount -= 1
	if enemy_amount <= 0: enemy_amount = 0
	spawn_cooldown_timer.start(spawn_cooldown_time)
		
# generate a spawn position
func spawn_position(enemy_y_offset: int):
	return Vector2(randi_range(left_x_offset, right_x_offset), enemy_y_offset)

# try spawn after a spawn cooldown
func on_spawn_cooldown_timeout() -> void:
	if can_respawn:
		spawn_enemy()
