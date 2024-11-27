extends Control
class_name PlayerStatsBar

@onready var health_bar: TextureProgressBar = get_node('HealthBarBackground/HealthBar')
@onready var mana_bar: TextureProgressBar = get_node('ManaBarBackground/ManaBar')
@onready var exp_bar: TextureProgressBar = get_node('ExpBarBackground/ExpBar')

enum BAR_TYPE {
	HEALTH,
	MANA,
	EXP
}

func init_bar():
	var player_stats: PlayerStats = get_window().get_node('Level/Player/PlayerStats')
	health_bar.max_value = player_stats.get_max_health()
	mana_bar.max_value = player_stats.get_max_mana()
	exp_bar.max_value = player_stats.get_lvl_exp(1)
	
	health_bar.value = player_stats.get_max_health()
	mana_bar.value = player_stats.get_max_mana()
	exp_bar.value = 0
	
func update_bar_max_value(bar_type: BAR_TYPE, max_value: int):
	if bar_type == BAR_TYPE.HEALTH:
		if health_bar == null: health_bar = get_node('HealthBarBackground/HealthBar')
		health_bar.max_value = max_value
	
	if bar_type == BAR_TYPE.MANA:
		if mana_bar == null: mana_bar = get_node('ManaBarBackground/ManaBar')
		mana_bar.max_value = max_value
		
	if bar_type == BAR_TYPE.EXP:
		if exp_bar == null: exp_bar = get_node('ExpBarBackground/ExpBar')
		exp_bar.max_value = max_value
	
func update_bar_value(bar_type: BAR_TYPE, final_value: int):
	if bar_type == BAR_TYPE.HEALTH:
		use_tween(health_bar, final_value)
	
	if bar_type == BAR_TYPE.MANA:
		use_tween(mana_bar, final_value)
		
	if bar_type == BAR_TYPE.EXP:
		use_tween(exp_bar, final_value)
		
func use_tween(bar: TextureProgressBar, final_value: int, property: String = 'value'):
	var tween = create_tween().bind_node(self)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(bar, property, final_value, 0.2)
	tween.play()

func _ready() -> void:
	init_bar()
	
func on_player_current_health_updated(health: int, current_health: int, type: String) -> void:
	#print('Update current health = ', str(current_health))
	update_bar_value(BAR_TYPE.HEALTH, current_health)

func on_player_max_health_updated(max_health: int) -> void:
	#print('Update max health = ', str(max_health))
	update_bar_max_value(BAR_TYPE.HEALTH, max_health)

func on_player_current_mana_updated(mana:int, current_mana: int, type: String) -> void:
	#print('Update current mana = ', str(current_mana))
	update_bar_value(BAR_TYPE.MANA, current_mana)

func on_player_max_mana_updated(max_mana: int, type: String) -> void:
	#print('Update max mana = ', str(max_mana))
	update_bar_max_value(BAR_TYPE.MANA, max_mana)

func on_player_current_exp_updated(exp: int, current_exp: int, type: String) -> void:
	#print('Update current exp = ', str(current_exp))
	update_bar_value(BAR_TYPE.EXP, current_exp)

func on_player_max_exp_updated(max_exp: int) -> void:
	#print('Update max exp = ', str(max_exp))
	update_bar_max_value(BAR_TYPE.EXP, max_exp)
