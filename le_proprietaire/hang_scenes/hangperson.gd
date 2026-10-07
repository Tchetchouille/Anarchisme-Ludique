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

# Advance the hangperson drawing by one step
func advance(step):
	if step < n_of_parts:
		parts[step].visible = true
		current_step += 1
	else:
		# Adding face based on character (propriétaire/comrade)
		if is_proprietaire:
			$Body/Head/FaceProprio.visible = true
		else:
			# The camarade face contains a head already, so we hide the main head
			$Body/Head/HeadSprite.visible = false
			$Body/Head/FaceCamarade.visible = true
	
func pends_ton_proprietaire():
	# Adding back physics
	for part in body_parts:
		part.freeze = false
	var random_impulse = rng.randi_range(-400.0, 400.0)
	$Body/Body.apply_impulse(Vector2(random_impulse, 0))


func _on_wait_for_confetti_timeout() -> void:
	pends_ton_proprietaire()
