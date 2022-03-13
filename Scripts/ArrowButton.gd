extends AnimatedSprite

var perfect = false
var good = false
var okay = false
var current_note = null

export var input = ""
var player_2_inputs = ["up_2", "left_2", "right_2"]
var player_1_inputs = ["up", "left", "right"]

func _unhandled_input(event):
	var player_number = 0
	if event.is_action(input):
		print(input)
		if player_1_inputs.has(input):
			player_number = 1
		elif player_2_inputs.has(input):
			player_number = 2
		else:
			player_number = 0
		if event.is_action_pressed(input, false):
			if current_note != null:
				if perfect:
					get_parent().increment_score(3, player_number)
					current_note.destroy(3)
				elif good:
					get_parent().increment_score(2, player_number)
					current_note.destroy(2)
				elif okay:
					get_parent().increment_score(1, player_number)
					current_note.destroy(1)
				_reset()
			else:
				get_parent().increment_score(0, player_number)
		if event.is_action_pressed(input):
			frame = 1
		elif event.is_action_released(input):
			$PushTimer.start()


func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		perfect = true


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		perfect = false


func _on_GoodArea_area_entered(area):
	if area.is_in_group("note"):
		good = true


func _on_GoodArea_area_exited(area):
	if area.is_in_group("note"):
		good = false


func _on_OkayArea_area_entered(area):
	if area.is_in_group("note"):
		okay = true
		current_note = area


func _on_OkayArea_area_exited(area):
	if area.is_in_group("note"):
		okay = false
		current_note = null


func _on_PushTimer_timeout():
	frame = 0


func _reset():
	current_note = null
	perfect = false
	good = false
	okay = false
