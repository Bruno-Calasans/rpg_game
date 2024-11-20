extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = get_node("Animation")
@export var speed = 150
@export var jump_speed = 75
@export var player_gravity = 1
@export var jump_count = 0
@export var landing = false
@export var attacking = false
@export var crouching = false
@export var can_crouch_now = false
@export var parrying = false
@export var can_parry_now = false
@export var can_move = true

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
	if is_on_floor():
		jump_count = 0
	
	# it lmits the number max of jumps by 2 and while not doind any other actions
	var can_jump = jump_count < 2 and can_move
	if Input.is_action_just_pressed('jump') and can_jump:
		jump_count += 1
		velocity.y = jump_speed
		
func gravity(delta: float):
	# it increases or decreases the player jumping speed or falling speed
	velocity.y += delta * player_gravity
	# it limits the falling speed or jumping speed
	if velocity.y > player_gravity: velocity.y = player_gravity

func attack():
	var can_attack = not attacking and not crouching and not parrying
	if Input.is_action_just_pressed('attack') and can_attack and is_on_floor():
		attacking = true
		can_move = false
		
func crouch():
	var can_crouch = is_on_floor() and not parrying and not crouching
	var can_stand = is_on_floor() and crouching and not parrying
	
	# crouch
	if Input.is_action_pressed('crouch') and can_crouch :
		crouching = true
		can_move = false
		can_crouch_now = true
	
	# standing
	if Input.is_action_just_released('crouch') and can_stand:
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
	
