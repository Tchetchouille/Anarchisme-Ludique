extends Button

@export var chars : String
signal letter_button_pressed(char:String)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(chars)
	#letter_button_pressed.connect(letter_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	disabled = true
	letter_button_pressed.emit(chars)
