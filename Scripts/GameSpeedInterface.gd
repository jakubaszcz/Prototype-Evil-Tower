extends HBoxContainer

@onready var game_speed_button : Button = $SpeedButton

var index : int = Global.gameplay_time

func _ready() -> void:
	Engine.time_scale = Global.gameplay_times_array[index]
	game_speed_button.text = "x" + str(Global.gameplay_times_array[index])

func _on_speed_button_pressed() -> void:
	index += 1
	if index >= Global.gameplay_times_array.size():
		index = 0
		
	Engine.time_scale = Global.gameplay_times_array[index]
	game_speed_button.text = "x" + str(Global.gameplay_times_array[index])
