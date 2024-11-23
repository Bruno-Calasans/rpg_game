extends Node
class_name PlayerStats

@export_category('Objects')
@onready var player_animation: PlayerAnimation = get_node('../Animation')
@onready var player: Player = get_node('..')

@export_category('Base Player Stats ')
@export var base_health = 20
@export var base_mana = 10
@export var base_defense = 1
@export var base_attack = 50
@export var base_magic_attack = 5

@export_category('Bonus Player Stats ')
@export var bonus_health = 0
@export var bonus_mana = 0
@export var bonus_defense = 0
@export var bonus_attack = 0
@export var bonus_magic_attack = 0

@export_category('Max Player Stats ')
@export var max_health = 0
@export var max_mana = 0
@export var max_defense = 0
@export var max_attack = 0
@export var max_magic_attack = 0
@export var max_level = 10

@export_category('Current Player Stats ')
@export var current_health = 0
@export var current_mana = 0
@export var current_level = 0
@export var current_experience = 0
@export var level_xp_requirements: Dictionary = {
	'0': 0,
	'1': 50,
	'2': 150,
	'3': 250,
	'4': 650,
	'5': 1050,
	'6': 2100,
	'7': 350,
	'8': 400,
	'9': 500,
	'10': 600
}

func _ready() -> void:
	update_max_health()
	update_max_mana()
	update_max_defense()
	reset_health_mana()
	
func get_lvl_exp(level: int):
	if level > len(level_xp_requirements): return level_xp_requirements['0']
	return level_xp_requirements[str(level)]
	
func update_xp(exp: int):
	current_experience += exp
	
	for lvl in range(1, max_level):
		var required_xp = get_lvl_exp(lvl)
		if current_experience >= required_xp and current_level < max_level:
			current_experience -= required_xp
			current_level += 1
			level_up()
		elif current_experience >= get_lvl_exp(max_level):
			current_experience = get_lvl_exp(max_level)
			break
		else:
			break

func update_max_health():
	max_health = base_health + bonus_health
	
func update_max_mana():
	max_mana = base_mana + bonus_mana

func update_max_defense():
	max_defense = base_defense + bonus_defense

func reset_health_mana():
	current_health = max_health
	current_mana = max_mana
	
func level_up():
	base_health += 2
	base_mana += 2
	base_defense += 2
	base_attack += 2
	base_magic_attack += 2
	update_max_health()
	update_max_mana()
	update_max_defense()
	reset_health_mana()

func get_attack():
	return base_attack + bonus_attack

func increase_health(value: int):
	current_health += value
	# it limits max health
	if current_health >= max_health: 
		current_health = max_health
	
func decrease_health(value: int):
	# if the player is taking damage
	var damage_taken = verify_parry(value)
	current_health -= damage_taken
	
	if current_health > 0:
		player.attacking = false
		player.being_hit = true
		# play damage animation
		
	if current_health <= 0:
		current_health = 0
		player.dead = true
		
func increase_mana(mana: int):
	current_mana += mana
	# it limits max mana
	if current_mana >= max_mana: 
		current_mana = max_mana

func decrease_mana(mana: int):
	if current_mana >= mana:
		current_mana -= mana
	
func verify_parry(damage: int):
	var taken_damage = damage
	
	if player.parrying: 
		taken_damage = abs(damage - max_defense)
	
	return taken_damage
	
		
func _physics_process(delta: float) -> void:
	# test player taking damage
	if Input.is_action_just_pressed('test'):
		print('Health before: ', current_health)
		decrease_health(5)
		print('Health after: ', current_health)
		
