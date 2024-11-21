extends CharacterBody2D
class_name Enemy

@export var player_ref: Player = null
@onready var texture: Sprite2D = get_node('Texture')
@onready var animation: AnimationPlayer = get_node('AnimationPlayer')


@export_category('Horizontal Move')
@export var enemy_gravity = 75
@export var enemy_speed = 1


func move():
	pass
	

func gravity(delta: float):
	velocity.y = delta * enemy_gravity

func _physics_process(delta: float) -> void:
	pass
