extends AnimatedSprite2D
class_name CrabbyEffect

@onready var crabby: Crabby = get_parent()

func create_effect() -> CrabbyEffect:
	var effect: PackedScene = load('res://scenes/enemy/crabby_effect.tscn')
	return effect.instantiate()
	
func apply_attack_effect():
	var effect = create_effect()
	crabby.add_child(effect)
	effect.global_position = crabby.global_position
	effect.play('attack')
	await effect.animation_finished
	effect.queue_free()
