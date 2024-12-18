extends EnemyAnimation
class_name PinkStarAnimation

func animate(velocity: Vector2):
	verify_direction(velocity)

	if enemy.being_hit or enemy.dead:
		damage_behavior()
	elif enemy.can_attack:
		attack_behavior()
	else:
		horizontal_behavior(velocity)
	
func horizontal_behavior(velocity: Vector2):
	if enemy.is_moving():
		play("run")
	else:
		play('idle')
	
func damage_behavior():
	enemy.set_physics_process(false)
	
	if enemy.dead:
		enemy.being_hit = false
		enemy.can_attack = false
		play('death')
		
	elif enemy.being_hit:
		play('hit')
		enemy.can_attack = false
		enemy.set_physics_process(false)
	
func attack_behavior():
	if enemy.can_attack and not enemy.attacking:
		play('attack_anticipation')
		enemy.set_physics_process(false)
	
func on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"attack_anticipation":
			if enemy.direction == 1:
				play('attack_right')
			elif enemy.direction == -1:
				play('attack_left')
			enemy.attacking = true
			
		"attack_left":
			enemy.can_attack = false
			enemy.being_hit = false
			enemy.attacking = false
			enemy.set_physics_process(true)
			
		"attack_right":
			enemy.can_attack = false
			enemy.being_hit = false
			enemy.attacking = false
			enemy.set_physics_process(true)

		"hit":
			enemy.set_physics_process(true)
			enemy.can_attack = true
			enemy.being_hit = false
			
		"death":
			play('kill')
			
		"kill":
			print('Pink Stars is dead')
			enemy.kill_enemy()
			
