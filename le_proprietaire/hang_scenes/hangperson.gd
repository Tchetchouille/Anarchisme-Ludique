extends Node2D

# Whether or not the person is a "propriétaire"
var is_proprietaire = true
var current_step : int = 0
var rng = RandomNumberGenerator.new()
# Parts of the hangman to draw for each wrong guess
@onready var parts = [
	$Scaffold/ScaffoldBase, 
	$Scaffold/ScaffoldBar, 
	$Scaffold/ScaffoldTop, 
	$Scaffold/ScaffoldSupport,
	$Body/Rope, 
	$Body/Head, 
	$Body/Body, 
	$Body/LeftArm, 
	$Body/RightArm, 
	$Body/LeftLeg, 
	$Body/RightLeg
]
# Parts of the hangman that need to be unfrozen
@onready var body_parts = [
	$Body/Head, 
	$Body/Body, 
	$Body/LeftArm, 
	$Body/RightArm, 
	$Body/LeftLeg, 
	$Body/RightLeg
]
@onready var n_of_parts = parts.size()


func _input(event):
	if event.is_action_pressed("ui_accept"):
		advance(current_step)

# Advance the hangperson drawing by one step
func advance(step):
	if step < n_of_parts:
		parts[step].visible = true
		current_step += 1
	else:
		pends_ton_proprietaire()

	
func pends_ton_proprietaire():
	# Adding back physics
	for part in body_parts:
		part.freeze = false
	# Adding face based on character (propriétaire/comrade)
	if is_proprietaire:
		$Body/Head/FaceProprio.visible = true
	else:
		$Body/Head/FaceCamarade.visible = true
	var random_impulse = rng.randi_range(-400.0, 400.0)
	$Body/Body.apply_impulse(Vector2(random_impulse, 0))
