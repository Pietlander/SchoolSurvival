extends Control

# Let op: Zorg dat je de knoppen via het 'Node' paneel (rechterkant) 
# met de 'pressed()' signalen koppelt aan deze functies!


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://World/World.tscn")

func _on_quit_button_pressed():
	get_tree().quit() 
