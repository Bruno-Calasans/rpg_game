extends Node2D
class_name ItemDropList

@onready var enemy: Enemy = get_parent()
@export var drop_list: Array[ItemInfo] = [] 

# determines the item drop quantity
func calc_drop_bonus():
	var drop_bonus = randi_range(1, 100)
	if drop_bonus <= 80:
		return 1
	elif drop_bonus <= 90:
		return 2
	else:
		return 3

func create_item() -> Item:
	var item_scene: PackedScene = load('res://scenes/item.tscn')
	return item_scene.instantiate()

func spawn_item(item_info: ItemInfo):
	var item = create_item()
	var level = get_window().get_node('Level')
	
	item.update_item_info(item_info)
	item.update_item_texture(item_info.item_path)
	item.spawn(enemy.global_position, level)

# determines which items and its quantity gonna drop
func drop_item():
	
	var max_itens = randi_range(1, 3)
	var dropped_itens = 0
	
	for item_info in drop_list:
		
		if dropped_itens >= max_itens: break
		
		var drop_chance = randi_range(1, 100)
		var item_drop_bonus = calc_drop_bonus()
		
		if drop_chance >= item_info.drop_chance:
			spawn_item(item_info)
			dropped_itens += 1
			
			
