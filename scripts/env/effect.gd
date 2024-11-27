extends AnimatedSprite2D
class_name Effect

func on_animation_finished() -> void:
	queue_free()
