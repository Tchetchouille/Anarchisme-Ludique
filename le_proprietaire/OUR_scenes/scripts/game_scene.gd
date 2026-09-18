extends Control

@export var all_words = null
@export var word = null

var word_found = []
var erreurs = 0
var tour = 0
#var scene : PackedScene = preload("res://text_scenes/dash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_words = FileAccess.open("res://data/liste_mots.txt", FileAccess.READ).get_as_text()
	all_words = Array(all_words.strip_edges().split("\n"))
	pick_random_word()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pick_random_word():
	word = all_words.pick_random()
	print(word)
	print(len(word))
	for x in word:
		word_found.append(false)
	display_word_dash()

func display_word_dash():
	var pre_dash = preload("res://text_scenes/dash.tscn")
	$VBoxContainer/ChosenWord/GridContainer/Center.size_flags_stretch_ratio = len(word)
	$VBoxContainer/ChosenWord/GridContainer/Center/Label.text = "_ ".repeat(len(word)).strip_edges()
	"""
	for i in word:
		var new_dash = scene.instantiate()
		new_dash.set_anchors_preset(5, true)
		new_dash.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		$GridContainer/Center.add_child(new_dash)
	"""

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
			pendre()
	if err:
		erreurs += 1
		if erreurs>=12:
			end_game_victoire()
	print(tour," --- ", erreurs)
	print(fin_string)
	$VBoxContainer/ChosenWord/GridContainer/Center/Label.text = fin_string.strip_edges()
	if Array(fin_string.strip_edges().split(" ")) == word_found:
		end_game_perdu()

func check_letter_in_word(char:String):
	var dico = {"letter":char, "changes":[]}
	var changes = []
	for c in word:
		changes.append(c in char)
	dico["changes"] = changes
	return dico

func end_game_perdu():
	pass

func end_game_victoire():
	$VBoxContainer/ChosenWord/Victory.emitting = true

func pendre():
	pass
