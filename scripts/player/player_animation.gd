extends AnimationPlayer
class_name PlayerAnimation

@onready var texture: Sprite2D = get_node('../Texture')
@onready var player: Player = get_node('..')
var attack_suffix = '_left'

func animate(direction: Vector2):
	verify_direction(direction)
	
	# this actions have priority over the actions below it
	if player.is_next_wall():
		wall_slide_behavior()
		print('here')
		
	elif player.attacking or player.crouching or player.parrying:
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
		player.wall_jump_direction = -1
		# it resets texture to the original position
		texture.position = Vector2.ZERO
		# it reverses raycast to right
		player.wall_ray.target_position = Vector2(10, 0)
		
	# going to left
	if direction.x < 0:
		texture.flip_h = true
		attack_suffix = '_left'
		player.wall_jump_direction = 1
		# it changes sprite/texture (it fixes the left side bug while doin wall slide)
		texture.position = Vector2(-5, 0)
		# it reverses raycast to left
		player.wall_ray.target_position = Vector2(-10, 0)
		
	# going to left
	if direction.x < 0:
		texture.flip_h = true
		attack_suffix = '_left'
		player.wall_jump_direction = 1
		# it changes sprite/texture (it fixes the left side bug while doin wall slide)
		texture.position = Vector2(-5, 0)

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
	if direction.y > 0 and not player.landing:
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
	
func wall_slide_behavior():
	if player.is_next_wall(): 
		play('wall_slide')
	
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
		
