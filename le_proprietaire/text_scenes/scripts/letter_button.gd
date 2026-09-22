extends Button

@export var chars : String
signal letter_button_pressed(char:String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(chars)


func _input(event):
	if event is InputEventKey and event.is_pressed():
		# This works but lead to an error:
		# Unicode parsing error, some characters were replaced with � (U+FFFD): Unexpected NUL character
		var key_char = char(event.unicode).to_upper()
		for character in chars.split():
			if character == key_char:
				activate()

func _on_pressed() -> void:
	activate()
	
func activate():
	if not disabled:
		disabled = true
		print(chars)
		$"../../../..".update_word(chars)
