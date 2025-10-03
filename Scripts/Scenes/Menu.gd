extends Node2D

func _ready() -> void:
	Global.load_progression()
	$CanvasLayer/Gems.text = "Gems : " + str(Global.ressources_gems)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Components/Scenes/Game.tscn")
