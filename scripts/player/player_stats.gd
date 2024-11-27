extends Node
class_name PlayerStats

signal player_current_health_updated(health: int, current_health: int, type: String)
signal player_current_mana_updated(mana: int, current_mana: int, type: String)
signal player_current_exp_updated(exp: int, current_exp: int, type: String)
signal player_max_health_updated(max_health: int)
signal player_max_mana_updated(max_mana: int)
signal player_max_exp_updated(max_exp: int)

@export_category('Objects')
@onready var player_animation: PlayerAnimation = get_node('../Animation')
@onready var player: Player = get_node('..')

@export_category('Base Player Stats ')
@export var base_health = 20
@export var base_mana = 10
@export var base_defense = 1
@export var base_attack = 5
@export var base_magic_attack = 5
@export var mana_cost = 5

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
@export var max_exp = 0

@export_category('Current Player Stats ')
@export var current_health = 0
@export var current_mana = 0
@export var current_level = 0
@export var current_experience = 0
@export var level_xp_requirements: Dictionary = {
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
	
func update_max_exp():
	max_exp = get_lvl_exp(current_level + 1)
	player_max_exp_updated.emit(max_exp)
		
func get_lvl_exp(level: int):
	if level > len(level_xp_requirements): 
		return level_xp_requirements[str(len(level_xp_requirements))]
	if level < 0:
		return level_xp_requirements['0']
	return level_xp_requirements[str(level)]
	
func update_xp(exp: int):
	current_experience += exp
	player_current_exp_updated.emit(exp, current_experience, 'increase')
	 
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

func get_max_health():
	return base_health + bonus_health

func update_max_health():
	max_health = base_health + bonus_health
	player_max_health_updated.emit(max_health)
	
func get_max_mana():
	return base_mana + bonus_mana

func update_max_mana():
	max_mana = base_mana + bonus_mana
	player_max_mana_updated.emit(max_mana, 'increase')

func update_max_defense():
	max_defense = base_defense + bonus_defense

func reset_health_mana():
	current_health = max_health
	current_mana = max_mana
	player_current_health_updated.emit(max_health, current_health, 'increase')
	player_current_mana_updated.emit(max_mana, current_mana, 'increase')
	
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
	update_max_exp()
	await get_tree().create_timer(0.2).timeout
	player_current_exp_updated.emit(current_experience)
	
func get_attack():
	return base_attack + bonus_attack

func increase_health(value: int):
	current_health += value
	# it limits max health
	if current_health >= max_health: 
		current_health = max_health
	player_current_health_updated.emit(value, current_health, 'increase')
	
func decrease_health(value: int):
	# if the player is taking damage
	var damage_taken = verify_parry(value)
	current_health -= damage_taken
	
	if current_health > 0:
		# player can't attack
		#player.attacking = false
		player.being_hit = true
		
	if current_health <= 0:
		current_health = 0
		player.dead = true
		
	player_current_health_updated.emit(damage_taken, current_health, 'decrease')
	
func increase_mana(mana: int):
	current_mana += mana
	# it limits max mana
	if current_mana >= max_mana: 
		current_mana = max_mana
	player_current_mana_updated.emit(mana, current_mana, 'increase')

func decrease_mana(mana: int):
	if current_mana >= mana:
		current_mana -= mana
	player_current_mana_updated.emit(mana, current_mana, 'decrease')
	
func verify_parry(damage: int):
	var taken_damage = damage
	
	if player.parrying:
		# min damage taken
		if  max_defense >= damage:
			taken_damage = 1
		else:
			taken_damage = abs(max_defense - damage)
	
	return taken_damage
		
func _physics_process(delta: float) -> void:
	# test player taking damage
	if Input.is_action_just_pressed('test'):
		decrease_health(5)
		
func on_enemy_is_dead(exp: int) -> void:
	print('Earned xp = ', str(exp))
	update_xp(exp)
