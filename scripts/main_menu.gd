extends Control
## English-first entry screen for the Naadan Adi 3D prototype.

var _title: Label
var _subtitle: Label
var _play: Button
var _quit: Button

func _ready() -> void:
	_build_ui()

func _build_ui() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = Color(0.018, 0.035, 0.055, 1.0)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var column := VBoxContainer.new()
	column.custom_minimum_size = Vector2(340, 0)
	column.add_theme_constant_override("separation", 14)
	center.add_child(column)

	_title = Label.new()
	_title.text = "NAADAN ADI HD"
	_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title.add_theme_font_size_override("font_size", 44)
	_title.add_theme_color_override("font_color", Color(0.94, 0.97, 1.0))
	column.add_child(_title)

	_subtitle = Label.new()
	_subtitle.text = "KERALA • 3D ARENA"
	_subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_subtitle.add_theme_font_size_override("font_size", 16)
	_subtitle.add_theme_color_override("font_color", Color(0.52, 0.78, 0.72))
	column.add_child(_subtitle)

	var spacer := Control.new()
	spacer.custom_minimum_size = Vector2(0, 18)
	column.add_child(spacer)

	_play = _make_button("PLAY")
	_play.pressed.connect(_on_play_pressed)
	column.add_child(_play)

	_quit = _make_button("EXIT")
	_quit.pressed.connect(_on_quit_pressed)
	column.add_child(_quit)

func _make_button(label_text: String) -> Button:
	var button := Button.new()
	button.text = label_text
	button.custom_minimum_size = Vector2(320, 58)
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.add_theme_font_size_override("font_size", 20)
	return button

func _on_play_pressed() -> void:
	var result := get_tree().change_scene_to_file("res://scenes/prototype_arena.tscn")
	if result != OK:
		push_error("Could not open prototype arena. Error code: %s" % result)

func _on_quit_pressed() -> void:
	get_tree().quit()
