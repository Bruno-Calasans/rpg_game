extends EnemyAnimation
class_name WhaleAnimation

func animate(velocity: Vector2):
	verify_direction(velocity)
	horizontal_behavior(velocity)
	pass
	
func horizontal_behavior(velocity: Vector2):
	if enemy.is_moving():
		play("run")
	else:
		play('idle')
	
func attack_behavior(velocity: Vector2):
	pass
	
func on_current_animation_changed(name: String) -> void:
	pass
