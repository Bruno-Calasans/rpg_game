extends ParallaxBackground
class_name Bakground

# it says if the parallax backgroound can move automatically
@export_category('Background vars')
@export var can_process = true

# it says the speed of each layer of the parallax background from layer1 to layer4
# from layer1 to layer4, the first layer is faster than the last one
@export var layer_speed: Array[float] = [20, 15, 10, 5]

func _ready() -> void:
	if can_process == false: 
		set_physics_process(false)
		
func _physics_process(delta: float) -> void:
	for index in get_child_count() - 1:
		
		var layer = get_child(index)
		if layer is ParallaxLayer:
			#+= positive if the player is moving to left (background moves to right)
			#-= negative if the player is moving to right (background moves to left)
			layer.motion_offset.x += delta * layer_speed[index]
			
			
	
			
			
		
