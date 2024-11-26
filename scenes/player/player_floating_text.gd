extends FloatingText
class_name PlayerFloatingText

func create_float_text():
	var float_text_scene: PackedScene = load('res://scenes/interface/general/floating_text.tscn')
	return float_text_scene.instantiate() as FloatingText
	
func spawn_float_text(prefix: String, suffix: String, type: String):
	var float_text = create_float_text()
	var player: Player = get_parent()
	
	float_text.text = '{prefix}{suffix}'.format({'prefix': prefix, 'suffix': suffix})
	float_text.modulate = float_text.text_colors[type]
	float_text.global_position = player.global_position
	get_window().call_deferred('add_child', float_text)

func on_player_current_health_updated(health: int, current_health: int, type: String) -> void:
	if type == 'increase':
		spawn_float_text('+', str(health), 'heal')
	elif type == 'decrease':
		spawn_float_text('-', str(health), 'damage')

func on_player_current_exp_updated(exp: int, current_exp: int, type: String) -> void:
	spawn_float_text('+', str(exp), 'exp')

func on_player_current_mana_updated(mana: int, current_mana: int, type: String) -> void:
	if type == 'increase':
		spawn_float_text('+', str(mana), 'mana')
	elif type == 'decrease':
		print('decrease mana')
		spawn_float_text('-', str(mana), 'mana')
