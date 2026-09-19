extends AnimatedSprite2D

@onready var anchor =  $"../Scaffold/Anchor"
@onready var head = $"../Body/Head"
var starting_dist : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_dist = head.global_position.y - anchor.global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var length = head.global_position.y - anchor.global_position.y
	look_at(Vector2(head.global_position.x, head.global_position.y))
	rotation_degrees -= 90
	scale = Vector2(0.6, 0.6 * length / starting_dist)
