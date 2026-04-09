extends Node

@onready var menu_music = $MenuMusic
@onready var game_music = $GameMusic


func play_menu_music():

	if not menu_music.playing:
		menu_music.play()
		game_music.stop()


func play_game_music():
	if not game_music.playing:
		game_music.play()
		menu_music.stop()
