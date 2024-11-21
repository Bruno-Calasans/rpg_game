extends CharacterBody2D
class_name Enemy

@export_category('Objects')
@export var player_ref: Player = null
@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var floor_raycast: RayCast2D = get_node('FloorRayCast')
@export var default_floor_raycast_x_position = 35

@export_category('Attack Variables')
@export var can_attack = false

@export_category('Horizontal Move')
@export var enemy_gravity = 75
@export var enemy_speed = 1
@export var aproximity_threshold = 1

func stop_enemy():
	velocity.x = 0

func is_moving():
	return velocity.x != 0

func get_player_enemy_distance():
	if player_ref == null: return Vector2()
	return player_ref.global_position - global_position

func floor_collision():
	return floor_raycast.is_colliding()

func horizontal_movement():
	if player_ref == null: stop_enemy()
	
	var distance = get_player_enemy_distance()
	var direction = sign(distance.x)
	
	# if player is right next to enemy
	if distance.x <= aproximity_threshold:
		stop_enemy()
		can_attack = true
	
	# enemy goes to player
	elif floor_collision() and not can_attack:
		velocity.x = direction * enemy_speed
		
	# enemy has not detected a floor
	else:
		stop_enemy()
		
func gravity(delta: float):
	velocity.y = delta * enemy_gravity

func animate():
	animation.animate(velocity)

func _physics_process(delta: float) -> void:
	horizontal_movement()
	gravity(delta)
	animate()
	move_and_slide()
