extends AnimatedSprite2D
class_name EnemyEffect

func create_effect() -> EnemyEffect:
	var enemy_effect_scene: PackedScene = load('res://scenes/enemy/enemy_effect.tscn')
	var enemy_effect = enemy_effect_scene.instantiate()
	return enemy_effect
	
