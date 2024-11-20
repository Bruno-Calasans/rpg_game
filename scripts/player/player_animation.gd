extends AnimationPlayer
class_name PlayerAnimation

@onready var texture: Sprite2D = get_node('../Texture')
@onready var player: Player = get_node('..')
var attack_suffix = '_left'

func animate(direction: Vector2):
	verify_direction(direction)
	
	# this actions have priority over the actions below it
	if player.attacking or player.crouching or player.parrying:
		action_behavior()
		
	# player is falling or jumping
	elif direction.y != 0:
		vertical_behavior(direction)
		
	# player is frozed while landing animation is playing
	elif player.landing == true:
		play('landing')
		# stop player while landing
		player.set_physics_process(false)
		
	# player is idle or running
	else:
		horizontal_behavior(direction)
	
	#print('Animate: {direction}'.format({'direction': direction}))

# it determines which position the player is looking at
func verify_direction(direction: Vector2):
	# going to right
	if direction.x > 0:
		texture.flip_h = false
		attack_suffix = '_right'
			
	# going to left
	if direction.x < 0:
		texture.flip_h = true
		attack_suffix = '_left'
		
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

func action_behavior():
	if player.attacking:
		play('attack' + attack_suffix)
			
	elif player.crouching and player.can_crouch_now: 
		play('crouch')
		player.can_crouch_now = false
		
	elif player.parrying and player.can_parry_now: 
		play('parry')
		player.can_parry_now = false
	
func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"landing":
			player.landing = false
			# player is unfrozed when landing animation stops
			player.set_physics_process(true)
		"attack_right":
			player.attacking = false
			player.can_move = true
		"attack_left":
			player.attacking = false
			player.can_move = true
		
