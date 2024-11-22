extends EnemyAnimation
class_name WhaleAnimation

func animate(velocity: Vector2):
	verify_direction(velocity)

	if enemy.being_hit or enemy.dead:
		damage_behavior()
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
			
func attack_behavior(velocity: Vector2):
	pass
	
func on_current_animation_changed(anim_name: String) -> void:
	match anim_name:
		"hit":
			enemy.set_physics_process(true)
			enemy.can_attack = true
			enemy.being_hit = false
			
		"death":
			play('kill')
			
		"kill":
			enemy.queue_free()
			
