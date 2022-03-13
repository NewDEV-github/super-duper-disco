extends Control

func _on_PlayAgain_pressed():
	if get_tree().change_scene("res://Scenes/Game_Multi.tscn") != OK:
			print ("Error changing scene to Game")


func _on_BackToMenu_pressed():
	if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")
func _ready():
	_render_score(1)
	_render_score(2)
func _render_score(player):
	var _t = "Player %s\n\nGrade: %s\nScore: %s\nBest combo: %s \nGreat notes: %s \nGood notes: %s \nOkay notes: %s \nMissed notes: %s"
	if player == 1:
		$VBoxContainer/HBoxContainer/Player1/Label.text = _t % [str(player), Global.grade_p1, Global.score_p1, Global.combo_p1, Global.great_p1, Global.good_p1, Global.okay_p1, Global.missed_p1]
	elif player == 2:
		$VBoxContainer/HBoxContainer/Player2/Label.text = _t % [str(player), Global.grade_p2, Global.score_p2, Global.combo_p2, Global.great_p2, Global.good_p2, Global.okay_p2, Global.missed_p2]
