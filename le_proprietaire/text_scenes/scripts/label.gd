extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().size_changed.connect(Callable(self, "window_size_changed"))
	window_size_changed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func window_size_changed():
	var ratio = float(get_window().size.y)/float(ProjectSettings.get_setting("display/window/size/viewport_height"))
	var calc_font_size = int(ratio * 32)
	set("theme_override_font_sizes/font_size", calc_font_size)
