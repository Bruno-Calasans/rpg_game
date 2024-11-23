extends Node2D
class_name Level

@onready var masks: Array[CanvasModulate] = [
	get_node('LevelDesign/Mask'),
	get_node('ParallaxBackground/Mask')
]

@onready var player_animation: PlayerAnimation = get_node('Player/Animation')

@export_category('Day Cycle')
@export var hour = 0
@export var day_night_cycle_colors: Dictionary = {
	'dawn': '#F8B195', # 00:00 to 5:59
	'sunrise': '#F8B195',
	'morning':'#ffffff',
	'sunset': '#C06C84',
	'dusk': '#6B5C7B',
	'night': '#355E7E'
} 

func _ready() -> void:
	player_animation.connect('game_over', game_over)

func game_over():
	print('Game Over')
	# reload this scene
	get_tree().reload_current_scene()
	
func day_cycle():
	if hour > 5 and hour < 6:
		for mask in masks:
			mask.color = Color(day_night_cycle_colors.get('dawn'))
		
	elif hour >= 6 and hour <= 7:
		for mask in masks:
			mask.color = Color(day_night_cycle_colors.get('sunrise'))
		
	elif hour > 7 and hour <= 14: 
		for mask in masks:
			mask.color = Color(day_night_cycle_colors.get('morning'))
		
	elif hour > 14 and hour <= 16:
		for mask in masks:
			mask.color = Color(day_night_cycle_colors.get('sunset'))
		
	elif hour > 17 and hour <= 18:
		for mask in masks:
			mask.color = Color(day_night_cycle_colors.get('dusk'))
	else:
		for mask in masks:
			mask.color = Color(day_night_cycle_colors.get('night'))
		
func _physics_process(delta: float) -> void:
	day_cycle()
	
func on_child_entered_tree(node: Node) -> void:
	print(node.name)
