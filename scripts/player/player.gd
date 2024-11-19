extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = get_node("Animation")
@export var speed: int = 150
@export var jump_speed: int = 75
@export var player_gravity: int = 1
@export var jump_count: int = 0
@export var landing = false

func horizontal_movement():
	# if you press both right and left, the character doesn't move (-1 + 1)
	# if you press only right, the character moves to right (0 + 1)
	# if you press only left, the character moves to left (-1 + 0)
	var horizontal_direction = - Input.get_action_strength('left') + Input.get_action_strength('right') 
	velocity.x = horizontal_direction * speed
	
	#
	animation.animate(velocity)
	print('Velocity: {velocity}'.format({'velocity': velocity}))

func vertical_moviment():
	# it 
	if is_on_floor():
		jump_count = 0
	
	# it lmits the number max of jumps by 2
	if Input.is_action_just_pressed('jump') and jump_count < 2:
		jump_count += 1
		velocity.y = jump_speed
		
func gravity(delta: float):
	# it increases or decreases the player jumping speed or falling speed
	velocity.y += delta * player_gravity
	# it limits the falling speed or jumping speed
	if velocity.y > player_gravity: velocity.y = player_gravity

func _physics_process(delta: float) -> void:
	horizontal_movement()
	vertical_moviment()
	gravity(delta)
	
	# A vector used to determine what's wall or floor
	# by default, it's Vector2.UP
	#set_up_direction(Vector2.UP)
	
	# move the player and return true if it encounters a collision
	move_and_slide()
	print(is_on_floor(), is_on_ceiling())
