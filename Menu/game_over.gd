extends Control

func _on_try_again_button_pressed():
	# Laadt het level opnieuw in. Pas de naam aan als jouw level anders heet!
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_menu_button_pressed():
	# Gaat terug naar het hoofdmenu
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")
