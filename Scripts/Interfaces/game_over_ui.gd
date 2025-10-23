extends CanvasLayer

func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if Game.is_game_over:
		visible = true
		$VBoxContainer/Gems.text = "Won gems : " + str(Game.game_gems)
		$"VBoxContainer/Total Gems".text = "Total gems : " + str(Global.sapphire - Game.game_gems) + " + " + str(Game.game_gems)




func _on_quit_pressed() -> void:
	Global.save_progression()
	get_tree().quit()


func _on_restart_pressed() -> void:
	Global.save_progression()
	print("current scene: " + get_tree().current_scene.name)
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	Global.save_progression()
	get_tree().change_scene_to_file("res://Components/Scenes/Menu.tscn")
