extends Effect
class_name PlayerEffect

@onready var player: Player = get_parent()

func create_effect() -> Effect:
	var player_effect_scene: PackedScene = load('res://scenes/effect/player_effect.tscn')
	var player_effect = player_effect_scene.instantiate()
	return player_effect
	
func apply_landing_effect(offset: Vector2):
	print('Applying landing effect')
	var effect = create_effect()
	player.add_child(effect)
	effect.global_position = player.global_position + offset
	effect.play('landing')

func apply_jump_effect(offset: Vector2):
	print('Applying jump effect')
	var effect = create_effect()
	player.add_child(effect)
	effect.global_position = player.global_position + offset
	if player.velocity.x < 0: effect.flip_h = true
	effect.play('jump')
	
func apply_run_effect(offset: Vector2):
	print('Applying run effect')
	var effect = create_effect()
	player.add_child(effect)
	effect.global_position = player.global_position + offset
	if player.velocity.x < 0: effect.flip_h = true
	effect.play('run')
