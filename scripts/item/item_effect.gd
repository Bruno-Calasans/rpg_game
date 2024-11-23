extends Effect
class_name ItemEffect


func create_effect() -> ItemEffect:
	var item_effect_scene: PackedScene = load('res://scenes/effect/item_effect.tscn')
	var item_effect = item_effect_scene.instantiate()
	return item_effect
	
func apply_interaction_effect():
	print('Applying interact effect')
	var item: Item = get_parent()
	var effect = create_effect()
	var level = get_window().get_node('Level')
	level.add_child(effect)
	effect.global_position = item.global_position
	effect.play('interaction')
