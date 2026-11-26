extends Control

var rng = RandomNumberGenerator.new()
var all_words = null 
var word = null
var game_ended = false
var word_found = []
var erreurs = 0
var tour = 0
var n_of_parts = 12
signal pendaison
@onready var hangperson = $HBoxContainer/Control/Hangperson
#var scene : PackedScene = preload("res://text_scenes/dash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_random_word()

func pick_random_word():
	hangperson.is_proprietaire = rng.randi_range(0, 1)
	var right_words = FileAccess.open("res://data/mots_droite.txt", FileAccess.READ).get_as_text()
	right_words = Array(right_words.strip_edges().split("\n"))
	var left_words = FileAccess.open("res://data/mots_gauche.txt", FileAccess.READ).get_as_text()
	left_words = Array(left_words.strip_edges().split("\n"))
	# If we are hanging the propriétaire, then the word must be from the right
	if hangperson.is_proprietaire:
		word = right_words.pick_random()
	# If we are hanging the père Duchesne, then the word must be from the left
	else:
		word = left_words.pick_random()
	for x in word:
		word_found.append(false)
	display_word_dash()

func display_word_dash():
	$HBoxContainer/VBoxContainer/ChosenWord/GridContainer/Center.size_flags_stretch_ratio = len(word)
	$HBoxContainer/VBoxContainer/ChosenWord/GridContainer/Center/Label.text = "_ ".repeat(len(word)).strip_edges()

func update_word(chara:String):
	if not game_ended:
		var dico = check_letter_in_word(chara)
		var fin_string = ""
		tour += 1
		var err  = !(true in dico["changes"])
		for i in range(len(dico["changes"])):
			if dico["changes"][i] or word_found[i]:
				fin_string += word[i] + " "
				word_found[i] = true
			else :
				fin_string += "_ "
		if err:
			$HBoxContainer/Control/Hangperson.advance(erreurs)
			erreurs += 1
			if erreurs>=n_of_parts:
				end_game_pendu()
		$HBoxContainer/VBoxContainer/ChosenWord/GridContainer/Center/Label.text = fin_string.strip_edges()
		if not '_' in fin_string:
			end_game_sauf()

func check_letter_in_word(chara:String):
	var dico = {"letter":chara, "changes":[]}
	var changes = []
	for c in word:
		changes.append(c in chara)
	dico["changes"] = changes
	return dico

func end_game_pendu():
	pendaison.emit()
	end_game()

func end_game_sauf():
	end_game()
	

func end_game():
	game_ended = true
	$"../ButtonShrinkTimer".start()

func _on_pends_ton_proprietaire_finally_hang() -> void:
	hangperson.get_node('FinallyHangTimer').start()
	if hangperson.is_proprietaire == 1:
		$"../Victory".emitting = true
		$"../Victory2".emitting = true
		$"../Victory3".emitting = true
	else:
		print("PAUVRE PÈRE DUCHESNE")


func _on_button_shrink_timer_timeout() -> void:
	var t = $"../RestartButtonTimer".wait_time
	$"../RestartButtonTimer".start()
	for button in $HBoxContainer/VBoxContainer/AllLetters.get_children():
		var tween = get_tree().create_tween()
		button.pivot_offset = button.size / 2
		tween.tween_property(button, "scale", Vector2(0, 0), t)


func _on_restart_button_timer_timeout() -> void:
	var container = $HBoxContainer/VBoxContainer
	var buttons = load("res://OUR_scenes/scripts/UI/end_buttons.tscn").instantiate()
	# We need to remove the word to be able to add the button on top
	var word_display = container.get_child(1)
	container.get_child(0).queue_free()
	container.remove_child(word_display)
	container.add_child(buttons)
	# We add the word back
	container.add_child(word_display)
