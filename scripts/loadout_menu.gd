extends Control
## Visual-card loadout prototype. Selections are local to this screen until save data is added.

var _category := "WEAPONS"
var _selected := "ASSAULT RIFLE"
var _equipped := "ASSAULT RIFLE"
var _selected_label: Label
var _cards: GridContainer
var _equip_button: Button
var _tab_buttons: Array[Button] = []

const CATALOG := {
	"WEAPONS": [
		{"name": "ASSAULT RIFLE", "detail": "Balanced  |  Damage 20  |  30 rounds"},
		{"name": "SMG", "detail": "Fast fire  |  Damage 13  |  40 rounds"},
		{"name": "SCOUT RIFLE", "detail": "Long range  |  Damage 35  |  8 rounds"}
	],
	"SKINS": [
		{"name": "JUNGLE CAMO", "detail": "Green tactical finish"},
		{"name": "LATERITE RED", "detail": "Kerala earth-tone finish"},
		{"name": "NIGHT OPS", "detail": "Dark low-gloss finish"},
		{"name": "COASTAL BLUE", "detail": "Harbour-inspired finish"}
	],
	"CHARACTER": [
		{"name": "FIELD OPERATIVE", "detail": "Light tactical outfit"},
		{"name": "HILL RANGER", "detail": "Outdoor field outfit"},
		{"name": "COAST GUARD", "detail": "Harbour patrol outfit"}
	],
	"MAPS": [
		{"name": "MUNNAR HILLS", "detail": "Tea estates and hillside lanes"},
		{"name": "FORT KOCHI", "detail": "Harbour streets and docks"},
		{"name": "BACKWATERS", "detail": "Canals, bridges and palms"},
		{"name": "WESTERN GHATS", "detail": "Forest trails and ridge routes"}
	]
}

func _ready() -> void:
	_build_ui()
	_show_category(_category)

func _build_ui() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = Color(0.018, 0.035, 0.055, 1.0)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 28)
	margin.add_theme_constant_override("margin_right", 28)
	margin.add_theme_constant_override("margin_top", 20)
	margin.add_theme_constant_override("margin_bottom", 20)
	add_child(margin)
	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 14)
	margin.add_child(layout)
	var heading := Label.new()
	heading.text = "LOADOUT  /  COLLECTION"
	heading.add_theme_font_size_override("font_size", 30)
	heading.add_theme_color_override("font_color", Color(0.93, 0.97, 1.0))
	layout.add_child(heading)
	var tabs := HBoxContainer.new()
	tabs.add_theme_constant_override("separation", 10)
	layout.add_child(tabs)
	for tab_name in ["WEAPONS", "SKINS", "CHARACTER", "MAPS"]:
		var tab := Button.new()
		tab.text = tab_name
		tab.custom_minimum_size = Vector2(130, 48)
		tab.pressed.connect(_on_tab_pressed.bind(tab_name))
		tabs.add_child(tab)
		_tab_buttons.append(tab)
	_cards = GridContainer.new()
	_cards.columns = 2
	_cards.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_cards.add_theme_constant_override("h_separation", 14)
	_cards.add_theme_constant_override("v_separation", 12)
	layout.add_child(_cards)
	_selected_label = Label.new()
	_selected_label.add_theme_font_size_override("font_size", 17)
	layout.add_child(_selected_label)
	var footer := HBoxContainer.new()
	footer.add_theme_constant_override("separation", 12)
	layout.add_child(footer)
	_equip_button = Button.new()
	_equip_button.text = "EQUIP SELECTED"
	_equip_button.custom_minimum_size = Vector2(220, 52)
	_equip_button.pressed.connect(_on_equip_pressed)
	footer.add_child(_equip_button)
	var back := Button.new()
	back.text = "BACK TO MENU"
	back.custom_minimum_size = Vector2(180, 52)
	back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/main_menu.tscn"))
	footer.add_child(back)

func _on_tab_pressed(tab_name: String) -> void:
	_category = tab_name
	_show_category(_category)

func _show_category(category: String) -> void:
	for child in _cards.get_children():
		child.queue_free()
	for tab in _tab_buttons:
		tab.disabled = tab.text == category
	var entries: Array = CATALOG[category]
	for entry in entries:
		var card := Button.new()
		card.custom_minimum_size = Vector2(250, 112)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		card.text = entry["name"] + "\n" + entry["detail"]
		card.pressed.connect(_on_card_selected.bind(entry["name"]))
		_cards.add_child(card)
	_selected = entries[0]["name"]
	_refresh_selection()

func _on_card_selected(item_name: String) -> void:
	_selected = item_name
	_refresh_selection()

func _refresh_selection() -> void:
	_selected_label.text = "SELECTED: %s     EQUIPPED: %s" % [_selected, _equipped]
	_equip_button.text = "EQUIP SELECTED" if _selected != _equipped else "EQUIPPED"
	_equip_button.disabled = _selected == _equipped

func _on_equip_pressed() -> void:
	_equipped = _selected
	_refresh_selection()
