extends CanvasLayer

func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if Game.is_game_over:
		visible = true
		$VBoxContainer/Gems.text = "Won gems : " + str(Game.game_gems)
		$"VBoxContainer/Total Gems".text = "Total gems : " + str(Global.ressources_gems - Game.game_gems) + " + " + str(Game.game_gems) 


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)


func _on_quit_pressed() -> void:
	get_tree().quit()
