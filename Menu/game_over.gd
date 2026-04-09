extends Control

func _on_try_again_button_pressed():
	
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_menu_button_pressed():

	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")
