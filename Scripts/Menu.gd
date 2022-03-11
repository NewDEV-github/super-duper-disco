extends Node2D

func _on_Start_Button_button_down():
	go_to_game()

func go_to_game(multi_mode:bool=false):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 
								linear2db($HSlider.value))
#	if get_tree().change_scene("res://Scenes/Game.tscn") != OK:
#		print ("Error changing scene to Game")
	Global.current_game_config_path ="res://Songs/VeryNiceSong/init.gd"
#	$SongSelector.show()
	Global.multi_mode = multi_mode
	if multi_mode:
		get_tree().change_scene("res://Scenes/Game_Multi.tscn")
	else:
		get_tree().change_scene("res://Scenes/Game.tscn")

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
								linear2db(value))


func _on_TextureButton_pressed():
	$TextureButton/AudioStreamPlayer.play()


func _on_Start_Button_MULTI_pressed():
	go_to_game(true)
