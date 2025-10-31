extends Control

# Visible
@onready var player_interface = $SubViewportContainer/SubViewport/Player
@onready var wave_interface = $SubViewportContainer/SubViewport/WaveManager
@onready var panel_interface = $GameContainer

# Panel
@onready var game_over_label : Label = $GameContainer/MarginContainer/VBoxContainer/GameOverLabel
@onready var reward_label : Label = $GameContainer/MarginContainer/VBoxContainer/RewardLabel

var is_over : bool = false

func _ready() -> void:
	reset()
	GameSignal.connect("s_game_over", Callable(self, "_on_game_over"))

func _physics_process(_delta: float) -> void:
	if is_over:
		reward_label.text = "You won " + str(Game.sapphire) + " Sapphire !"

func reset():
	is_over = false
	player_interface.visible = true
	wave_interface.visible = true
	panel_interface.visible = false

func _on_game_over(reason):
	is_over = true
	player_interface.visible = false
	wave_interface.visible = false
	panel_interface.visible = true
	
	if reason == "player_died":
		game_over_label.text = "You are dead !"
	reward_label.text = "You won " + str(Game.sapphire) + " Sapphire !"

func _on_quit_button_pressed() -> void:
	Global.save_progression()
	get_tree().quit()


func _on_restart_button_pressed() -> void:
	Global.save_progression()
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	Global.save_progression()
	get_tree().change_scene_to_file("res://Components/Scenes/Menu.tscn")
