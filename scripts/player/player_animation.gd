extends AnimationPlayer
class_name PlayerAnimation

@onready var texture: Sprite2D = get_node('../Texture')

func animate(direction: Vector2):
	verify_direction(direction)
	horizontal_behavior(direction)
	
	#print('Animate: {direction}'.format({'direction': direction}))

# it determines which position the player is looking at
func verify_direction(direction: Vector2):
	if direction.x > 0:
		texture.flip_h = false
		
	if direction.x < 0:
		texture.flip_h = true
		
	#else:
	#	flip_h = true
	
func horizontal_behavior(velocity: Vector2):
	if velocity.x != 0:
		# play running animation
		play('run')
	else:
		#play idle animation
		play('idle')
