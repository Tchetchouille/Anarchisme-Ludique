extends GridContainer

var alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

var scene : PackedScene = preload("res://text_scenes/letter_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for char in alphabet:
		var new_button = scene.instantiate()
		new_button.text=char
		var chars = char
		match char:
			"A": chars += "ÂÀ"
			"C": chars += "Ç"
			"E": chars += "ÉÈÊË"
			"I": chars += "ÏÎ"
			"O": chars += "Ô"
			"U": chars += "ÜÛÙ"
		new_button.chars = chars
		add_child(new_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
