extends FloatingText
class_name EnemyFloatingText

func create_float_text():
	var float_text_scene: PackedScene = load('res://scenes/interface/general/floating_text.tscn')
	return float_text_scene.instantiate() as FloatingText
	

func spawn_float_text(prefix: String, suffix: String, type: String):
	var float_text = create_float_text()
	var enemy: Enemy = get_parent()
	
	float_text.text = '{prefix}{suffix}'.format({'prefix': prefix, 'suffix': suffix})
	float_text.modulate = float_text.text_colors[type]
	float_text.global_position = Vector2(enemy.global_position.x - 6, enemy.global_position.y + 6)
	get_window().call_deferred('add_child', float_text)


func on_enemy_health_update(health: int, current_health: int, type: String) -> void:
	if type == 'increase':
		spawn_float_text('+', str(health), 'heal')
	elif type == 'decrease':
		spawn_float_text('-', str(health), 'damage')
