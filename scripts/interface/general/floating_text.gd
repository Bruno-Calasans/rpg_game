extends Label
class_name FloatingText

@export_category('Text Physics')
@export var velocity = 100
@export var gravity = 2
@export var mass = 2
@export var text_colors = {
	'heal': Color('#2CDB93'),
	'damage': Color('#DB442C'),
	'mana': Color('#4F74DB'),
	'exp': Color('#FFBF00')
}

func _ready() -> void:
	randomize()
	#random_impulse()
	fade_out_text()
	
func random_impulse():
	velocity = Vector2(randi_range(-30, 30), -10)
	
func fade_out_text():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	
	# increases its size
	tween.tween_property(self, 'scale', Vector2(1, 1), 0.3)
	# decreases its size
	tween.tween_property(self, 'scale', Vector2(0.4, 0.4), 1).set_delay(0.3)
	# it fades out
	tween.parallel().tween_property(self, 'modulate:a', 0, 0.3).from(1).set_delay(0.7)
	tween.play()
	
	#await tween.finished
	#queue_free()
	
func _process(delta: float) -> void:
	pass
	#velocity = gravity * mass * delta
	#global_position += velocity * delta
	
