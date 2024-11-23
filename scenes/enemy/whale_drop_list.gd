extends ItemDropList
class_name WhaleDropList

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
		'Whale Mouth', 
		'res://assets/item/resource/whale/whale_mouth.png',
		40, 
		ItemInfo.ITEM_TYPE.RESOURCE,
		2,
		),
	ItemInfo.new(
		'Whale Eye', 
		'res://assets/item/resource/whale/whale_eye.png',
		40, 
		ItemInfo.ITEM_TYPE.RESOURCE,
		2),
	ItemInfo.new(
		'Whale Tail', 
		'res://assets/item/resource/whale/whale_tail.png',
		5, 
		ItemInfo.ITEM_TYPE.RESOURCE,
		25),
	ItemInfo.new(
		'Whale Mask', 
		'res://assets/item/equipment/whale_mask.png',
		10, 
		ItemInfo.ITEM_TYPE.EQUIPMENT,
		30,
		{
			'increase_max_mana': 5,
			'increase_magic_attack_damage': 3
		})
	]
