extends Control
## English-first entry screen for the Naadan Adi 3D prototype.

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
	var title := Label.new()
	title.text = "NAADAN ADI HD"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 44)
	title.add_theme_color_override("font_color", Color(0.94, 0.97, 1.0))
	column.add_child(title)
	var subtitle := Label.new()
	subtitle.text = "KERALA  •  3D ARENA"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 16)
	subtitle.add_theme_color_override("font_color", Color(0.52, 0.78, 0.72))
	column.add_child(subtitle)
	var spacer := Control.new()
	spacer.custom_minimum_size = Vector2(0, 18)
	column.add_child(spacer)
	_add_button(column, "PLAY", _on_play_pressed)
	_add_button(column, "LOADOUT", _on_loadout_pressed)
	_add_button(column, "EXIT", _on_quit_pressed)

func _add_button(parent: VBoxContainer, label_text: String, action: Callable) -> void:
	var button := Button.new()
	button.text = label_text
	button.custom_minimum_size = Vector2(320, 58)
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.add_theme_font_size_override("font_size", 20)
	button.pressed.connect(action)
	parent.add_child(button)

func _on_play_pressed() -> void:
	var result := get_tree().change_scene_to_file("res://scenes/prototype_arena.tscn")
	if result != OK:
		push_error("Could not open prototype arena. Error code: %s" % result)

func _on_loadout_pressed() -> void:
	var result := get_tree().change_scene_to_file("res://scenes/loadout_menu.tscn")
	if result != OK:
		push_error("Could not open loadout menu. Error code: %s" % result)

func _on_quit_pressed() -> void:
	get_tree().quit()
