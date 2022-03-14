extends Control

func _on_PlayAgain_pressed():
	if get_tree().change_scene("res://Scenes/Game.tscn") != OK:
			print ("Error changing scene to Game")


func _on_BackToMenu_pressed():
	if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")
func _ready():
	_render_score()
func _render_score():
	var _t = "Player 1\n\nGrade: %s\nScore: %s\nBest combo: %s \nGreat notes: %s \nGood notes: %s \nOkay notes: %s \nMissed notes: %s"
	$VBoxContainer/HBoxContainer/Player/Label.text = _t % [Global.grade, Global.score, Global.combo, Global.great, Global.good, Global.okay, Global.missed]
