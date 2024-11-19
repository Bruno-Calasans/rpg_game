extends AnimationPlayer
class_name PlayerAnimation

@onready var texture: Sprite2D = get_node('../Texture')
@onready var player: Player = get_node('..')

func animate(direction: Vector2):
	verify_direction(direction)
	# player is falling or jumping
	if direction.y != 0:
		vertical_behavior(direction)
		
	elif player.landing == true:
		play('landing')
		# player is frozed while landing animation is playing
		player.set_physics_process(false)
	# player is idle or running
	else:
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
		
func vertical_behavior(direction: Vector2):
	# player is jumping
	if  direction.y < 0:
		player.landing = false
		play("jump")
	# player is falling
	if direction.y > 0:
		player.landing = true
		play('fall')


func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"landing":
			player.landing = false
			# player is unfrozed when landing animation stops
			player.set_physics_process(true)
