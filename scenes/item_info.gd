extends Node2D
class_name ItemInfo

enum ITEM_TYPE {
	CONSUMABLE,
	EQUIPMENT,
	RESOURCE,
	WEAPON
}

var item_name: String = ''
var item_path: NodePath = ''
var drop_chance: int = 0
var item_type: ITEM_TYPE = ITEM_TYPE.CONSUMABLE
var sell_value: int = 0
var stats: Dictionary = {}
var quant: int = 1
var max_stack: int = 10

func _init(
	item_name: String = '', 
	item_path: NodePath = '', 
	drop_chance: int = 0, 
	item_type: ITEM_TYPE = ITEM_TYPE.CONSUMABLE, 
	sell_value: int = 0,
	stats: Dictionary = {}
	) -> void:
		self.item_name = item_name
		self.item_path = item_path
		self.drop_chance = drop_chance
		self.item_type = item_type
		self.sell_value = sell_value
		self.stats = stats
