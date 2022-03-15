extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var end_song_position = 404
var bpm = 115
var song_name = "Very Nice Song"
var measures = 4
var play_offset = 8 
var song_file_path = "res/songs/VeryNiceSong/song.ogg"
var notes_spawn = {
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
var notes_spawn_multi_1 = {
	"36": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 1,
		"spawn_4_beat": 1,
	},
	"98": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
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
var notes_spawn_multi_2 = {
	"36": {
		"spawn_1_beat": 1,
		"spawn_2_beat": 1,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
	},
	"98": {
		"spawn_1_beat": 2,
		"spawn_2_beat": 0,
		"spawn_3_beat": 1,
		"spawn_4_beat": 0,
	},
	"132": {
		"spawn_1_beat": 0,
		"spawn_2_beat": 0,
		"spawn_3_beat": 0,
		"spawn_4_beat": 0,
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
