extends Control
## Lightweight bilingual entry menu. English is the default; Malayalam is optional.

var _malayalam := false
var _title: Label
var _subtitle: Label
var _play: Button
var _language: Button
var _quit: Button

func _ready() -> void:
	_build_ui()
	_refresh_text()

func _build_ui() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = Color(0.025, 0.075, 0.08, 1.0)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var column := VBoxContainer.new()
	column.custom_minimum_size = Vector2(360, 0)
	column.add_theme_constant_override("separation", 16)
	center.add_child(column)

	_title = Label.new()
	_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title.add_theme_font_size_override("font_size", 42)
	column.add_child(_title)

	_subtitle = Label.new()
	_subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_subtitle.add_theme_font_size_override("font_size", 16)
	column.add_child(_subtitle)

	_play = _make_button(column)
	_play.pressed.connect(_on_play_pressed)
	_language = _make_button(column)
	_language.pressed.connect(_on_language_pressed)
	_quit = _make_button(column)
	_quit.pressed.connect(_on_quit_pressed)

func _make_button(parent: VBoxContainer) -> Button:
	var button := Button.new()
	button.custom_minimum_size = Vector2(320, 58)
	button.add_theme_font_size_override("font_size", 20)
	parent.add_child(button)
	return button

func _refresh_text() -> void:
	if _malayalam:
		_title.text = "നാടൻ അടി"
		_subtitle.text = "കേരളത്തിന്റെ സ്വന്തം 3D അരീന"
		_play.text = "കളി തുടങ്ങാം"
		_language.text = "English"
		_quit.text = "പുറത്തുകടക്കുക"
	else:
		_title.text = "NAADAN ADI"
		_subtitle.text = "KERALA'S OWN 3D ARENA"
		_play.text = "PLAY"
		_language.text = "മലയാളം"
		_quit.text = "QUIT"

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/prototype_arena.tscn")

func _on_language_pressed() -> void:
	_malayalam = not _malayalam
	_refresh_text()

func _on_quit_pressed() -> void:
	get_tree().quit()
