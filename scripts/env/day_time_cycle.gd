extends Node2D
class_name Level

@export var hour = 0
@onready var mask1 = $LevelDesign/Mask
@onready var mask2 = $ParallaxBackground/Mask
@export var day_night_cycle_colors: Dictionary = {
	'dawn': '#F8B195', # 00:00 to 5:59
	'sunrise': '#F8B195',
	'morning':'#ffffff',
	'sunset': '#C06C84',
	'dusk': '#6B5C7B',
	'night': '#355E7E'
} 

func _physics_process(delta: float) -> void:
	
		if hour > 5 and hour < 6:
			mask1.color = Color(day_night_cycle_colors.get('dawn'))
			mask2.color = Color(day_night_cycle_colors.get('dawn'))
		
		elif hour >= 6 and hour <= 7:
			mask1.color = Color(day_night_cycle_colors.get('sunrise'))
			mask2.color = Color(day_night_cycle_colors.get('sunrise'))
			
		elif hour > 7 and hour <= 14:
			mask1.color = Color(day_night_cycle_colors.get('morning'))
			mask2.color = Color(day_night_cycle_colors.get('morning'))
			
		elif hour > 14 and hour <= 16:
			mask1.color = Color(day_night_cycle_colors.get('sunset'))
			mask2.color = Color(day_night_cycle_colors.get('sunset'))
			
		elif hour > 17 and hour <= 18:
			mask1.color = Color(day_night_cycle_colors.get('dusk'))
			mask2.color = Color(day_night_cycle_colors.get('dusk'))
			
		else:
			mask1.color = Color(day_night_cycle_colors.get('night'))
			mask2.color = Color(day_night_cycle_colors.get('night'))
		
