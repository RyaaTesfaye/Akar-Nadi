extends Control

const MAIN_ARENA_SCENE: String = "res://scenes/world/main_arena.tscn"

@onready var play_button: Button = $MarginContainer/VBoxContainer/ButtonContainer/PlayButton
@onready var settings_button: Button = $MarginContainer/VBoxContainer/ButtonContainer/SettingsButton
@onready var quit_button: Button = $MarginContainer/VBoxContainer/ButtonContainer/QuitButton

@onready var settings_panel: Panel = $SettingsPanel
@onready var volume_slider: HSlider = $SettingsPanel/VBoxContainer/VolumeSlider
@onready var close_settings_button: Button = $SettingsPanel/VBoxContainer/CloseSettingsButton

func _ready() -> void:
	settings_panel.visible = false
	
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	close_settings_button.pressed.connect(_on_close_settings_pressed)
	volume_slider.value_changed.connect(_on_volume_changed)
	
	var master_bus_idx = AudioServer.get_bus_index("Master")
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_idx))

func _on_play_pressed() -> void:
	if ResourceLoader.exists(MAIN_ARENA_SCENE):
		get_tree().change_scene_to_file(MAIN_ARENA_SCENE)
	else:
		print("WARNING: File main_arena.tscn belum dibuat!")

func _on_settings_pressed() -> void:
	settings_panel.visible = true

func _on_close_settings_pressed() -> void:
	settings_panel.visible = false

func _on_volume_changed(value: float) -> void:
	var master_bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(value))

func _on_quit_pressed() -> void:
	get_tree().quit()
