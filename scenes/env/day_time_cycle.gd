extends CanvasModulate

@export var hour = 0
@onready var mask = $"."
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
			mask.color = Color(day_night_cycle_colors.get('dawn'))
		
		elif hour >= 6 and hour <= 7:
			mask.color = Color(day_night_cycle_colors.get('sunrise'))
			
		elif hour > 7 and hour <= 14:
			mask.color = Color(day_night_cycle_colors.get('morning'))
			
		elif hour > 14 and hour <= 16:
			mask.color = Color(day_night_cycle_colors.get('sunset'))
			
		elif hour > 17 and hour <= 18:
			mask.color = Color(day_night_cycle_colors.get('dusk'))
			
		else:
			mask.color = Color(day_night_cycle_colors.get('night'))
		
