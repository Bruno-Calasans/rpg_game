extends AnimationPlayer
class_name EnemyTexture

@onready var enemy: Enemy = get_parent()
@onready var texture: Sprite2D = get_node('Texture')
@onready var floor_raycast: RayCast2D = get_node('../FloorRayCast')
@export var default_floor_raycast_x_position = 35

func animate(velocity: Vector2):
	verify_direction(velocity)
	pass
	
func verify_direction(velocity: Vector2):
	var direction = sign(enemy.get_player_enemy_distance().x)
	
	# player is on the right
	# by default, the enemy is looking at the left
	if direction > 0:
		# turn right
		texture.flip_h = true 
		# deslocate the raycast position to the right
		floor_raycast.position.x = default_floor_raycast_x_position
	
	# player is on the left
	if direction < 0:
		# turn left
		texture.flip_h = false 
		# deslocate the raycast position to the left
		floor_raycast.position.x = -default_floor_raycast_x_position
	
func move_behavior(velocity):
	pass
	
func attack_behavior(velocity):
	pass
	
func on_current_animation_changed(name: String) -> void:
	pass
