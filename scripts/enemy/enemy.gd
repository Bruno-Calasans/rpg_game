extends CharacterBody2D
class_name Enemy

signal enemy_is_dead(exp: int)

@export_category('Objects')
@export var player_ref: Player = null
@onready var animation: AnimationPlayer = get_node('Animation')
@onready var floor_raycast: RayCast2D = get_node('FloorRayCast')
@export var enemy_variant = 'Default'
@onready var drop_list: ItemDropList = get_node('ItemDropList')
@export var enemy_exp = 30

@export_category('Attack Variables')
@export var can_attack = false
@export var attacking = false
@export var aproximity_threshold = 1
@export var dead = false
@export var being_hit = false
@export var direction = 1

@export_category('Horizontal Move')
@export var enemy_gravity = 350
@export var enemy_speed = 50
@export var default_floor_raycast_x_position = 35

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
	if player_ref == null: 
		stop_enemy()
		return
		
	var distance = get_player_enemy_distance()
	var direction = sign(distance.x)
	var can_move = floor_collision() and not can_attack and not attacking
	
	# if player is right next to enemy
	if abs(distance.x) <= aproximity_threshold and not can_attack:
		stop_enemy()
		can_attack = true
		#print('Enemy attacks')
	
	# enemy goes to player
	elif can_move:
		velocity.x = direction * enemy_speed
		#print('Enemy moves')
		
	# enemy has not detected a floor
	else:
		stop_enemy()
		#print('Enemy stops')
		
func gravity(delta: float):
	velocity.y = delta * enemy_gravity

func animate():
	animation.animate(velocity)
	
func kill_enemy():
	drop_list.drop_item()
	queue_free()
	enemy_is_dead.emit(enemy_exp)

func _physics_process(delta: float) -> void:
	horizontal_movement()
	gravity(delta)
	animate()
	move_and_slide()
