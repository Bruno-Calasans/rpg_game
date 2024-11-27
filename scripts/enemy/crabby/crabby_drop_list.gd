extends ItemDropList
class_name CrabbyDropList

func _ready() -> void:
	randomize()
	drop_list = [
	ItemInfo.new(
		'Health Potion', 
		'res://assets/item/consumable/health_potion.png',
		20, 
		ItemInfo.ITEM_TYPE.CONSUMABLE,
		5,
		{
			'increase_health': 5
		}),
	ItemInfo.new(
		'Mana Potion', 
		'res://assets/item/consumable/mana_potion.png',
		20, 
		ItemInfo.ITEM_TYPE.CONSUMABLE, 
		5,
		{
			'increase_mana': 5
		}),
	ItemInfo.new(
		'Crabby Axe', 
		"res://assets/item/equipment/crabby_axe.png",
		40, 
		ItemInfo.ITEM_TYPE.EQUIPMENT,
		2,
		{
			'increase_atk': 3,
			'increase_defense': 3
		}
		),
	ItemInfo.new(
		'Crabby Belt', 
		"res://assets/item/resource/crabby/crab_eye.png",
		40, 
		ItemInfo.ITEM_TYPE.EQUIPMENT,
		2, {
			'increase_health': 3,
			'increase_attack': 3
		}),
	ItemInfo.new(
		'Crabby Eye', 
		'res://assets/item/resource/crabby/crab_eye.png',
		35, 
		ItemInfo.ITEM_TYPE.RESOURCE,
		2),
	ItemInfo.new(
		'Crabby Pincers', 
		"res://assets/item/resource/crabby/crab_pincers.png",
		40, 
		ItemInfo.ITEM_TYPE.RESOURCE,
		2),
	]
