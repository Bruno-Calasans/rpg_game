extends CharacterBody2D
class_name Player

@export_category('Objects')
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var wall_ray: RayCast2D = get_node('WallRay')
@onready var player_stats: PlayerStats = get_node('PlayerStats')

@export_category('Damage')
@export var dead = false
@export var being_hit = false
@export var game_over = false

@export_category('Horizontal Movement')
@export var speed = 100 # how much the x value is going increase (left or right)
@export var direction = 1

@export_category('Vertical Movement')
@export var jump_speed = -175 # how much the y (up) value is going increase (when jumping)
@export var player_gravity = 350 # how much the y (down) value is going increase
@export var jump_count = 0 # how much jumps the player can do it
@export var landing = false # if the player is landing after jumping

@export_category('Main Actions')
@export var attacking = false # if the player is attacking
@export var casting = false # if the player is cast some spell
@export var crouching = false # if the player is crouching
@export var parrying = false # if the player is defending (using the shield)
@export var can_move = true # if the player can move after it peforms some action
@export var can_crouch_now = false # if the player can crouch after crouching before
@export var can_parry_now = false # if the player can parry after parrying before

@export_category('Wall Slide')
@export var on_wall = false # if the player is on the wall
@export var on_wall_before = false # if the player is on the wall
@export var wall_jump_speed = -150 # how much the y (up) value is going increase (when jumping on the wall)
@export var wall_gravity = 115 # how much the y (down) value is going increase (when sliding on the wall)
@export var wall_impulse_speed = 500 # how much the x value is going increase (left or right) after jumping
@export var wall_jump_direction = 1 # 1 (right) or -1 (left)

func horizontal_movement():
	# if you press both right and left, the character doesn't move (-1 + 1)
	# if you press only right, the character moves to right (0 + 1)
	# if you press only left, the character moves to left (-1 + 0)
	if not can_move:
		velocity.x = 0
		return
	var horizontal_direction = - Input.get_action_strength('left') + Input.get_action_strength('right') 
	velocity.x = horizontal_direction * speed
	#print('Velocity: {velocity}'.format({'velocity': velocity}))

func vertical_moviment():
	# it resets jump count
	if is_on_floor() or is_on_wall():
		jump_count = 0
	
	# it lmits the number max of jumps by 2 and while not doind any other actions
	var can_jump = jump_count < 2 and can_move
	if Input.is_action_just_pressed('jump') and can_jump:
		jump_count += 1
		# jump from a wall
		if is_next_wall() and not is_on_floor():
			velocity.y = wall_jump_speed
			velocity.x += wall_impulse_speed * wall_jump_direction
		# jump from a floor
		else:
			#print('jumping')
			velocity.y = jump_speed
		
func gravity(delta: float):
	
	# gravity is modified if the player is next a wall	
	if is_next_wall(): 
		velocity.y += delta * wall_gravity
		
		# it limits the wall_gravity
		if velocity.y >= wall_gravity: 
			velocity.y = wall_gravity
		
	# gravity in the air
	else: 
		# it increases or decreases the player jumping speed or falling speed
		velocity.y += delta * player_gravity
		
		# it limits the falling speed or jumping speed
		if velocity.y >= player_gravity: 
			velocity.y = player_gravity
	
func is_next_wall():
	# if the player is on the wall without touching the floor
	if wall_ray.is_colliding() and not is_on_floor(): 
		
		# if it's the first time the player is on the wall
		if not on_wall_before:
			# it resets vertical velocity
			velocity.y = 0
			on_wall_before = true
		return true
		
	on_wall_before = false
	return false
		
func attack():
	var can_attack = not attacking and not casting and not crouching and not parrying and is_on_floor()
	var can_magic_attack = player_stats.current_mana >= player_stats.mana_cost
	
	if Input.is_action_just_pressed('attack') and can_attack:
		attacking = true
		can_move = false
	
	elif Input.is_action_just_pressed('magic_attack') and can_attack and can_magic_attack:
		casting = true
		can_move = false
		player_stats.decrease_mana(player_stats.mana_cost)
		
func crouch():
	var can_crouch = is_on_floor() and not crouching and not parrying 
	var can_stand = is_on_floor() and crouching and not parrying
	
	# crouch
	if Input.is_action_pressed('crouch') and can_crouch :
		#print('Player is crouching')
		crouching = true
		can_move = false
		can_crouch_now = true
	
	# standing
	if Input.is_action_just_released('crouch') and can_stand:
		#print('Player is standing')
		crouching = false
		can_move = true
		can_crouch_now = false
		
func parry():
	var can_parry = is_on_floor() and not parrying and not crouching
	var can_stop_parry = is_on_floor() and parrying and not crouching
	
	if Input.is_action_pressed('parry') and can_parry:
		parrying = true
		can_move = false
		can_parry_now = true
		
	if Input.is_action_just_released('parry') and can_stop_parry:
		parrying = false
		can_move = true
		can_parry_now = false
		
func actions():
	attack()
	crouch()
	parry()

func _physics_process(delta: float) -> void:
	horizontal_movement()
	vertical_moviment()
	gravity(delta)
	actions()
	
	# A vector used to determine what's wall or floor
	# by default, it's Vector2.UP
	#set_up_direction(Vector2.UP)
	
	# move the player and return true if it encounters a collision
	move_and_slide()
	
	#
	animation.animate(velocity)
	
