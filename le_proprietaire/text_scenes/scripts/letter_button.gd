extends Button

@export var chars : String
signal letter_button_pressed(char:String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(chars)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	disabled = true
	print(chars)
	$"../../../..".update_word(chars)
	
