extends Control

func _ready():
	
	MusicManager.play_menu_music()

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://World/World.tscn")

func _on_quit_button_pressed():
	get_tree().quit() 
