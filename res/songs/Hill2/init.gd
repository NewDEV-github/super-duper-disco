extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var initialize = false
var end_song_position = 292
var bpm = 140
var song_name = "Hill 2"
var song_author = "DoS"
var song_album = "Super Duper Disco"
var measures = 4
var play_offset = 0.5
var song_file_path = "res/songs/Hill2/full.mp3"
var notes_spawn = {
	"0": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"27": {
		"spawn_1_beat": 1,
		"spawn_2_beat": 1,
		"spawn_3_beat": 1,
		"spawn_4_beat": 1,
	},
	"292": {"end": 0}
}
var notes_spawn_multi_1 = {
	"0": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"27": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 1,
		"spawn_4_beat": 1,
	},
	"292": {"end": 0}
}
var notes_spawn_multi_2 = {
	"0": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"27": {
		"spawn_1_beat": 1,
		"spawn_2_beat": 1,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"292": {"end": 0}
}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

