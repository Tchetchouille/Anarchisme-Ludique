extends Control

@export var all_words = null
@export var word = null

var game_ended = false
var word_found = []
var erreurs = 0
var tour = 0
var n_of_parts = 12
#var scene : PackedScene = preload("res://text_scenes/dash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_words = FileAccess.open("res://data/liste_mots.txt", FileAccess.READ).get_as_text()
	all_words = Array(all_words.strip_edges().split("\n"))
	pick_random_word()

func pick_random_word():
	word = all_words.pick_random()
	for x in word:
		word_found.append(false)
	display_word_dash()

func display_word_dash():
	var pre_dash = preload("res://text_scenes/dash.tscn")
	$HBoxContainer/VBoxContainer/ChosenWord/GridContainer/Center.size_flags_stretch_ratio = len(word)
	$HBoxContainer/VBoxContainer/ChosenWord/GridContainer/Center/Label.text = "_ ".repeat(len(word)).strip_edges()

func update_word(char:String):
	var dico = check_letter_in_word(char)
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
			end_game_victoire()
	$HBoxContainer/VBoxContainer/ChosenWord/GridContainer/Center/Label.text = fin_string.strip_edges()
	if not '_' in fin_string:
		end_game_perdu()

func check_letter_in_word(char:String):
	var dico = {"letter":char, "changes":[]}
	var changes = []
	for c in word:
		changes.append(c in char)
	dico["changes"] = changes
	return dico

func end_game_perdu():
	end_game()

func end_game_victoire():
	end_game()
	$HBoxContainer/VBoxContainer/ChosenWord/Victory.emitting = true

func end_game():
	game_ended = true
	for button in $HBoxContainer/VBoxContainer/AllLetters.get_children():
		button.disabled = true
