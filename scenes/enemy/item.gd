extends RigidBody2D
class_name Item

var player_ref: Player = null

# throw the item at a random direction
func apply_random_impulse():
	apply_impulse(Vector2(randi_range(-30, 30), -90), Vector2.ZERO)
	
func update_item_texture(path: NodePath):
	var item_texture = get_node('ItemTexture') as Sprite2D
	item_texture.texture = load(str(path))

func update_item_info(info: ItemInfo):
	var item_info = get_node('ItemInfo') as ItemInfo
	item_info = info
	
func spawn(spawn_position: Vector2, where: Node2D):
	global_position = spawn_position
	apply_random_impulse()
	where.add_child(self)

# when the item exits the screen, remove it from memory
func on_screen_exited() -> void:
	queue_free()

# player adds item to its inventory
func interaction():
	if Input.is_action_just_pressed('interact') and player_ref != null:
		print('Player gets a item')
		queue_free()
		
func _process(delta: float) -> void:
	interaction()
	
