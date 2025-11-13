extends Control

# Visible
@onready var player_interface = $SubViewportContainer/SubViewport/Player
@onready var wave_interface = $SubViewportContainer/SubViewport/WaveManager
@onready var panel_interface = $GameContainer
@onready var pause_interface = $PauseContainer

# Panel
@onready var game_over_label : Label = $GameContainer/MarginContainer/VBoxContainer/GameOverLabel
@onready var reward_label : Label = $GameContainer/MarginContainer/VBoxContainer/RewardLabel

var is_over : bool = false
var is_exit : bool = false

func _ready() -> void:
	get_tree().paused = false
	reset()
	set_process_input(true)
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameSignal.connect("s_game_over", Callable(self, "_on_game_over"))
	GameSignal.connect("s_exit", Callable(self, "_on_exit"))

func _physics_process(_delta: float) -> void:
	if is_over:
		game_over_label.text = "You are dead !"
		if Global.bonus_sapphire > 0:
			reward_label.text = "You won " + Utils.format_number(Game.sapphire) + " + " + Utils.format_number(Global.bonus_sapphire) + "% Sapphire !"
		else:
			reward_label.text = "You won " + Utils.format_number(Game.sapphire) + " Sapphire !"
		

func _input(event):
	if not is_over and event.is_action_pressed("key_exit"):
		GameSignal.emit_signal("s_exit")

func _on_exit():
	is_exit = not is_exit
	print("Paused : " + str(is_exit))
	pause_interface.visible = is_exit
	get_tree().paused = is_exit

func reset():
	is_over = false
	is_exit = false
	player_interface.visible = true
	pause_interface.visible = false
	wave_interface.visible = true
	panel_interface.visible = false

func _on_game_over(reason):
	is_over = true
	player_interface.visible = false
	wave_interface.visible = false
	panel_interface.visible = true
	get_tree().paused = is_over

		
func _on_quit_button_pressed() -> void:
	Global.save_progression()
	get_tree().quit()
	get_tree().paused = false


func _on_restart_button_pressed() -> void:
	Global.save_progression()
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	Global.save_progression()
	get_tree().change_scene_to_file("res://Components/Scenes/Menu.tscn")


func _on_stop_button_pressed() -> void:
	reset()
	GameSignal.emit_signal("s_game_over", "player_abandon")
