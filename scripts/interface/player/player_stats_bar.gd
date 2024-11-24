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
	var tween = create_tween()
	#tween.bind_node(bar)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(bar, property, final_value, 0.2)
	tween.play()

func _ready() -> void:
	init_bar()
	
func on_player_current_health_updated(current_health: int) -> void:
	print('Update current health')
	update_bar_value(BAR_TYPE.HEALTH, current_health)

func on_player_max_health_updated(max_health: int) -> void:
	print('Update max health')
	update_bar_max_value(BAR_TYPE.HEALTH, max_health)

func on_player_current_mana_updated(current_mana: int) -> void:
	print('Update current mana')
	update_bar_value(BAR_TYPE.MANA, current_mana)

func on_player_max_mana_updated(max_mana: int) -> void:
	print('Update max mana')
	update_bar_max_value(BAR_TYPE.MANA, max_mana)

func on_player_current_exp_updated(current_exp: int) -> void:
	print('Update current exp')
	update_bar_value(BAR_TYPE.EXP, current_exp)

func on_player_max_exp_updated(max_exp: int) -> void:
	print('Update max exp')
	update_bar_max_value(BAR_TYPE.EXP, max_exp)
