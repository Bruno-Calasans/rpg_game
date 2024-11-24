extends Area2D
class_name FireballSpell

var spell_damage = 0

func _ready() -> void:
	# starts the particles animation
	for child in get_children():
		if child is CPUParticles2D and child.name != 'Explosion3':
			child.emitting = true

# remove particles after animation ends
func on_spell_animation_animation_finished(anim_name: StringName) -> void:
	queue_free()
