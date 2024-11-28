extends ItemDropList
class_name PinkStarDropList

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
		'Pink Star Bow', 
		"res://assets/item/equipment/pink_star_bow.png",
		5, 
		ItemInfo.ITEM_TYPE.WEAPON,
		60,
		{
			'increase_atk': 5,
		}
		),
	ItemInfo.new(
		'Pink Star Belt', 
		"res://assets/item/equipment/pink_star_belt.png",
		5, 
		ItemInfo.ITEM_TYPE.EQUIPMENT,
		40,
		{
			'increase_health': 5,
			'increase_mana': 5,
		}
		),
	ItemInfo.new(
		'Pink Star Shield', 
		"res://assets/item/resource/crabby/crab_eye.png",
		40, 
		ItemInfo.ITEM_TYPE.WEAPON,
		2, {
			'increase_defense': 5
		}),
	ItemInfo.new(
		'Pink Star Mouth', 
		"res://assets/item/resource/pink_star/pink_star_mouth.png",
		47, 
		ItemInfo.ITEM_TYPE.RESOURCE,
		5),
	]
