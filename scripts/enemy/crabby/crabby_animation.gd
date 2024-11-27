extends EnemyAnimation
class_name CrabbyAnimation

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
	
func attack_behavior():
	if enemy.can_attack and not enemy.attacking:
		if enemy.direction == 1:
			enemy.attacking = true
			play('attack_right')
		elif enemy.direction == -1:
			enemy.attacking = true
			play('attack_left')
		
func on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"attack_left":
			enemy.can_attack = false
			enemy.being_hit = false
			enemy.attacking = false
		"attack_right":
			enemy.can_attack = false
			enemy.being_hit = false
			enemy.attacking = false
		"hit":
			enemy.set_physics_process(true)
			enemy.can_attack = true
			enemy.being_hit = false
			
		"death":
			play('kill')
			
		"kill":
			print('Crabby is dead')
			enemy.kill_enemy()
			
