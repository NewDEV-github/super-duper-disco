extends Node2D
enum MultiGameModes {
	SeparatedNotes = 0
	RandomizedNotes = 1
	DuplicatedNotes = 2
}
var install_base_path = OS.get_executable_path().get_base_dir() + "/"
var multi_game_mode = MultiGameModes.DuplicatedNotes
var multi_mode = false
var score = 0
var score_p1 = 0
var score_p2 = 0
var combo = 0
var combo_p1 = 0
var combo_p2 = 0
var great = 0
var great_p1 = 0
var great_p2 = 0
var good = 0
var good_p1 = 0
var good_p2 = 0
var okay = 0
var okay_p1 = 0
var okay_p2 = 0
var missed = 0
var missed_p1 = 0
var missed_p2 = 0
var grade = "NA"
var grade_p1 = "NA"
var grade_p2 = "NA"
var current_game_config_path = "NA"

func set_score(new):
	score = new
	if score > 250000:
		grade = "A+"
	elif score > 200000:
		grade = "A"
	elif score > 150000:
		grade = "A-"
	elif score > 130000:
		grade = "B+"
	elif score > 115000:
		grade = "B"
	elif score > 100000:
		grade = "B-"
	elif score > 85000:
		grade = "C+"
	elif score > 70000:
		grade = "C"
	elif score > 55000:
		grade = "C-"
	elif score > 40000:
		grade = "D+"
	elif score > 30000:
		grade = "D"
	elif score > 20000:
		grade = "D-"
	else:
		grade = "F"
		

func set_score_p1(new):
	score_p1 = new
	if score_p1 > 250000:
		grade_p1 = "A+"
	elif score_p1 > 200000:
		grade_p1 = "A"
	elif score_p1 > 150000:
		grade_p1 = "A-"
	elif score_p1 > 130000:
		grade_p1 = "B+"
	elif score_p1 > 115000:
		grade_p1 = "B"
	elif score_p1 > 100000:
		grade_p1 = "B-"
	elif score_p1 > 85000:
		grade_p1 = "C+"
	elif score_p1 > 70000:
		grade_p1 = "C"
	elif score_p1 > 55000:
		grade_p1 = "C-"
	elif score_p1 > 40000:
		grade_p1 = "D+"
	elif score_p1 > 30000:
		grade_p1 = "D"
	elif score_p1 > 20000:
		grade_p1 = "D-"
	else:
		grade_p1 = "F"
		

func set_score_p2(new):
	score_p2 = new
	if score_p2 > 250000:
		grade_p2 = "A+"
	elif score_p2 > 200000:
		grade_p2 = "A"
	elif score_p2 > 150000:
		grade_p2 = "A-"
	elif score_p2 > 130000:
		grade_p2 = "B+"
	elif score_p2 > 115000:
		grade_p2 = "B"
	elif score_p2 > 100000:
		grade_p2 = "B-"
	elif score_p2 > 85000:
		grade_p2 = "C+"
	elif score_p2 > 70000:
		grade_p2 = "C"
	elif score_p2 > 55000:
		grade_p2 = "C-"
	elif score_p2 > 40000:
		grade_p2 = "D+"
	elif score_p2 > 30000:
		grade_p2 = "D"
	elif score_p2 > 20000:
		grade_p2 = "D-"
	else:
		grade_p2 = "F"
		
