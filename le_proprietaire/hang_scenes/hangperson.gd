extends Node2D

var current_step : int = 0
# Will hold the number of steps for drawing the scaffold
var scaffold_threshold : int
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scaffold_threshold = $Scaffold.get_child_count()
	pends_ton_proprietaire()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		advance(current_step)

# Advance the hangperson drawing by one step
func advance(step):
	if step < scaffold_threshold:
		$Scaffold.get_child(step).visible = true
	else:
		activate_bodypart(current_step - scaffold_threshold)
	current_step += 1

func activate_bodypart(i):
	pass
	
func pends_ton_proprietaire():
	var random_impulse = rng.randi_range(-400.0, 400.0)
	$Body/Body.apply_impulse(Vector2(random_impulse, 0))
