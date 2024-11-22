extends Enemy
class_name Whale


func _ready() -> void:
	randomize()
	drop_list = {
		'Health Potion': {
			'path': 'res://assets/item/consumable/health_potion.png',
			'drop_chance': 20,
			'sell_value': 5,
			'type': 'consumable',
			'stats': {
				'increase_health': 5
			}
		},
		'Mana Potion': {
			'path': 'res://assets/item/consumable/mana_potion.png',
			'drop_chance': 20,
			'sell_value': 5,
			'type': 'consumable',
			'stats': {
				'increase_mana': 5
			}
		},
		'Whale Mouth': {
			'path': 'res://assets/item/resource/whale/whale_mouth.png',
			'drop_chance': 40,
			'sell_value': 2,
			'type': 'resource',
			'stats': {}
		},
			'Whale Eye': {
			'path': 'res://assets/item/resource/whale/whale_eye.png',
			'drop_chance': 5,
			'sell_value': 25,
			'type': 'resource',
			'stats': {}
		},
			'Whale Tail': {
			'path': 'res://assets/item/resource/whale/whale_tail.png',
			'drop_chance': 5,
			'sell_value': 25,
			'type': 'resource',
			'stats': {}
		},
			'Whale Mask': {
			'path': 'res://assets/item/equipment/whale_mask.png',
			'drop_chance': 10,
			'sell_value': 15,
			'type': 'equipment',
			'stats': {
				'increase_max_mana': 5,
				'increase_magic_attack_damage': 3
			}
		}
	}
