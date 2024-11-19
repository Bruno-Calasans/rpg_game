extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var speed: float = 75

func horizontal_movement():
	# if you press both right and left, the character doesn't move (-1 + 1)
	# if you press only right, the character moves to right (0 + 1)
	# if you press only left, the character moves to left (-1 + 0)
	var horizontal_direction = - Input.get_action_strength('left') + Input.get_action_strength('right') 
	velocity.x = horizontal_direction * speed
	
	# move the player and return true if it encounters a collision
	move_and_slide()
	
	#
	animation.animate(velocity)
	print('Velocity: {velocity}'.format({'velocity': velocity}))


func _physics_process(delta: float) -> void:
	horizontal_movement()
