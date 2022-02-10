extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var song_notes = {
	"36": {
		"spawn_1_beat": 1,
		"spawn_2_beat": 1,
		"spawn_3_beat": 1,
		"spawn_4_beat": 1,
	},
	"98": {
		"spawn_1_beat": 2,
		"spawn_2_beat": 0,
		"spawn_3_beat": 1,
		"spawn_4_beat": 0,
	},
	"132": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 2,
		"spawn_3_beat": 0,
		"spawn_4_beat": 2,
	},
	"162": {
		"spawn_1_beat": 2,
		"spawn_2_beat": 2,
		"spawn_3_beat": 1,
		"spawn_4_beat": 1,
	},
	"194": {
		"spawn_1_beat": 2,
		"spawn_2_beat": 2,
		"spawn_3_beat": 1,
		"spawn_4_beat": 2,
	},
	"228": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 2,
		"spawn_3_beat": 1,
		"spawn_4_beat": 2,
	},
	"258": {
		"spawn_1_beat": 1,
		"spawn_2_beat": 2,
		"spawn_3_beat": 1,
		"spawn_4_beat": 2,
	},
	"288": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 2,
		"spawn_3_beat": 0,
		"spawn_4_beat": 2,
	},
	"322": {
		"spawn_1_beat": 3,
		"spawn_2_beat": 2,
		"spawn_3_beat": 2,
		"spawn_4_beat": 1,
	},
	"388": {
		"spawn_1_beat": 1,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"396": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"404": {"end": 0}
}
var song_bpm = 115
var song_beat_offset = 8
var song_measures = 4
var song_name = "Very Nice Song"
var song_filename = "song.ogg"
# Called when the node enters the scene tree for the first time.
func _ready():
	save_song("user://saved_songs/")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func save_song(path):
	var cfg = ConfigFile.new()
	var dir = Directory.new()
	if not dir.dir_exists(path):
		dir.make_dir_recursive(path)
	cfg.load(path + song_name + "_config.cfg")
	dir.make_dir_recursive(path + song_name + "_config_data")
	cfg.set_value("song_data", "bpm", song_bpm)
	cfg.set_value("song_data", "measures", song_measures)
	cfg.set_value("song_data", "filename", song_filename)
	cfg.set_value("song_data", "beat_offset", song_beat_offset)
	cfg.set_value("song_data", "notes_str", str(song_notes))
	cfg.set_value("song_data", "notes", song_notes)
	cfg.set_value("song_data", "name", str(song_name))
	cfg.save(path + song_name + "_config.cfg")

func add_notes_from_beat(start_posiiton:int=0, spawn_1:int=0, spawn_2:int=0, spawn_3:int=0, spawn_4:int=0):
	song_notes[str(start_posiiton)] = {"spawn_1_beat": spawn_1, "spawn_2_beat": spawn_2, "spawn_3_beat": spawn_3, "spawn_4_beat": spawn_4}
func add_notes_end(position:int=0):
	song_notes[str(position)] = {"end": 0}


func _on_Conductor_beat(position):
	$VBoxContainer/Position/SpinBox.value = position


func _on_Play_toggled(button_pressed):
	pass # Replace with function body.


func _on_Play_pressed():
	$Conductor.play_with_beat_offset(int($VBoxContainer/PlayOffset/SpinBox.value))


func _on_AddNotes_pressed():
	add_notes_from_beat(int($WindowDialog/VBoxContainer/StartPosition/SpinBox.value), int($WindowDialog/VBoxContainer/Spawn1/SpinBox.value), int($WindowDialog/VBoxContainer/Spawn2/SpinBox.value), int($WindowDialog/VBoxContainer/Spawn3/SpinBox.value), int($WindowDialog/VBoxContainer/Spawn4/SpinBox.value))


func _on_AddNotesPopup_pressed():
	$AddNotesPopup.popup_centered()
