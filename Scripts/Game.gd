extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 1
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = preload("res://Scenes/Note.tscn")
var instance
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

func _ready():
	randomize()
	if Global.current_game_config_path != "NA":
		load_song(Global.current_game_config_path)


func _input(event):
	if event.is_action("escape"):
		if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")

func load_song(config_file:String):
	var file = File.new()
	var cfile = ConfigFile.new()
	cfile.load(config_file)
	$Conductor.bpm = int(cfile.get_value("song_data", "bpm"))
	$Conductor.measures = int(cfile.get_value("song_data", "measures")) #MAX 4
	var song_file_name = cfile.get_value("song_data", "filename")
	print("user://saved_songs/" + config_file.get_file().trim_suffix("."+config_file.get_extension()) + '_data/' + song_file_name)
	var full_song_path = "user://saved_songs/" + config_file.get_file().trim_suffix("."+config_file.get_extension()) + '_data/' + song_file_name
	$Conductor.stream = ParseAudioAsStreamData(full_song_path)
	print("Notes: " + str(cfile.get_value("song_data", "notes")))
	print(typeof(cfile.get_value("song_data", "notes")))
	notes_spawn = cfile.get_value("song_data", "notes")
	$Conductor.play_with_beat_offset(int(cfile.get_value("song_data", "beat_offset")))
func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	print(str(position))
	song_position_in_beats = position
	for i in notes_spawn:
		if song_position_in_beats >= i.to_int():
			if notes_spawn[i] == {"end": 0}:
				Global.set_score(score)
				Global.combo = max_combo
				Global.great = great
				Global.good = good
				Global.okay = okay
				Global.missed = missed
				if get_tree().change_scene("res://Scenes/End.tscn") != OK:
					print ("Error changing scene to End")
			else:
				spawn_1_beat = int(notes_spawn[i]["spawn_1_beat"])
				spawn_2_beat = int(notes_spawn[i]["spawn_2_beat"])
				spawn_3_beat = int(notes_spawn[i]["spawn_3_beat"])
				spawn_4_beat = int(notes_spawn[i]["spawn_4_beat"])
func report_errors(err, filepath):
	# See: https://docs.godotengine.org/en/latest/classes/class_@globalscope.html#enum-globalscope-error
	var result_hash = {
		ERR_FILE_NOT_FOUND: "File: not found",
		ERR_FILE_BAD_DRIVE: "File: Bad drive error",
		ERR_FILE_BAD_PATH: "File: Bad path error.",
		ERR_FILE_NO_PERMISSION: "File: No permission error.",
		ERR_FILE_ALREADY_IN_USE: "File: Already in use error.",
		ERR_FILE_CANT_OPEN: "File: Can't open error.",
		ERR_FILE_CANT_WRITE: "File: Can't write error.",
		ERR_FILE_CANT_READ: "File: Can't read error.",
		ERR_FILE_UNRECOGNIZED: "File: Unrecognized error.",
		ERR_FILE_CORRUPT: "File: Corrupt error.",
		ERR_FILE_MISSING_DEPENDENCIES: "File: Missing dependencies error.",
		ERR_FILE_EOF: "File: End of file (EOF) error."
	}
	if err in result_hash:
		print("Error: ", result_hash[err], " ", filepath)
	else:
		print("Unknown error with file ", filepath, " error code: ", err)

func ParseAudioAsStreamData(filepath):
#	print("AUDIO AT: " + filepath)
#	var file = File.new()
#	var err = file.open(filepath, File.READ)
#	if err != OK:
#		report_errors(err, filepath)
#		file.close()
#		return AudioStreamSample.new()
#
#	var bytes = file.get_buffer(file.get_length())
#
#	# if File is wav
#	if filepath.ends_with(".wav"):
#
#		var newstream = AudioStreamSample.new()
#
#		#---------------------------
#		#parrrrseeeeee!!! :D
#
#		for i in range(0, 100):
#			var those4bytes = str(char(bytes[i])+char(bytes[i+1])+char(bytes[i+2])+char(bytes[i+3]))
#
#			if those4bytes == "RIFF": 
#				print ("RIFF OK at bytes " + str(i) + "-" + str(i+3))
#				#RIP bytes 4-7 integer for now
#			if those4bytes == "WAVE": 
#				print ("WAVE OK at bytes " + str(i) + "-" + str(i+3))
#
#			if those4bytes == "fmt ":
#				print ("fmt OK at bytes " + str(i) + "-" + str(i+3))
#
#				#get format subchunk size, 4 bytes next to "fmt " are an int32
#				var formatsubchunksize = bytes[i+4] + (bytes[i+5] << 8) + (bytes[i+6] << 16) + (bytes[i+7] << 24)
#				print ("Format subchunk size: " + str(formatsubchunksize))
#
#				#using formatsubchunk index so it's easier to understand what's going on
#				var fsc0 = i+8 #fsc0 is byte 8 after start of "fmt "
#
#				#get format code [Bytes 0-1]
#				var format_code = bytes[fsc0] + (bytes[fsc0+1] << 8)
#				var format_name
#				if format_code == 0: format_name = "8_BITS"
#				elif format_code == 1: format_name = "16_BITS"
#				elif format_code == 2: format_name = "IMA_ADPCM"
#				print ("Format: " + str(format_code) + " " + format_name)
#				#assign format to our AudioStreamSample
#				newstream.format = format_code
#
#				#get channel num [Bytes 2-3]
#				var channel_num = bytes[fsc0+2] + (bytes[fsc0+3] << 8)
#				print ("Number of channels: " + str(channel_num))
#				#set our AudioStreamSample to stereo if needed
#				if channel_num == 2: newstream.stereo = true
#
#				#get sample rate [Bytes 4-7]
#				var sample_rate = bytes[fsc0+4] + (bytes[fsc0+5] << 8) + (bytes[fsc0+6] << 16) + (bytes[fsc0+7] << 24)
#				print ("Sample rate: " + str(sample_rate))
#				#set our AudioStreamSample mixrate
#				newstream.mix_rate = sample_rate
#
#				#get byte_rate [Bytes 8-11] because we can
#				var byte_rate = bytes[fsc0+8] + (bytes[fsc0+9] << 8) + (bytes[fsc0+10] << 16) + (bytes[fsc0+11] << 24)
#				print ("Byte rate: " + str(byte_rate))
#
#				#same with bits*sample*channel [Bytes 12-13]
#				var bits_sample_channel = bytes[fsc0+12] + (bytes[fsc0+13] << 8)
#				print ("BitsPerSample * Channel / 8: " + str(bits_sample_channel))
#
#				#aaaand bits per sample/bitrate [Bytes 14-15] - TODO: Handle different bitrates
#				var bits_per_sample = bytes[fsc0+14] + (bytes[fsc0+15] << 8)
#				print ("Bits per sample: " + str(bits_per_sample))
#
#
#			if those4bytes == "data":
#				var audio_data_size = bytes[i+4] + (bytes[i+5] << 8) + (bytes[i+6] << 16) + (bytes[i+7] << 24)
#				print ("Audio data/stream size is " + str(audio_data_size) + " bytes")
#
#				var data_entry_point = (i+8)
#				print ("Audio data starts at byte " + str(data_entry_point))
#
#				newstream.data = bytes.subarray(data_entry_point, data_entry_point+audio_data_size-1)
#
#			# end of parsing
#			#---------------------------
#
#		#get samples and set loop end
#		var samplenum = newstream.data.size() / 4
#		newstream.loop_end = samplenum
#		newstream.loop_mode = 1 #change to 0 or delete this line if you don't want loop, also check out modes 2 and 3 in the docs
#		return newstream  #:D
#
#	#if file is ogg
#	elif filepath.ends_with(".ogg"):
#		var newstream = AudioStreamOGGVorbis.new()
#		newstream.loop = true #set to false or delete this line if you don't want to loop
#		newstream.data = bytes
#		return newstream
#
#	#if file is mp3
#	elif filepath.ends_with(".mp3"):
#		var newstream = AudioStreamMP3.new()
#		newstream.loop = true #set to false or delete this line if you don't want to loop
#		newstream.data = bytes
#		return newstream
#
#	else:
#		print ("ERROR: Wrong filetype or format")
#	file.close()
	return load(filepath)
#	if song_position_in_beats > 36:
#		spawn_1_beat = 1
#		spawn_2_beat = 1
#		spawn_3_beat = 1
#		spawn_4_beat = 1
#	if song_position_in_beats > 98:
#		spawn_1_beat = 2
#		spawn_2_beat = 0
#		spawn_3_beat = 1
#		spawn_4_beat = 0
#	if song_position_in_beats > 132:
#		spawn_1_beat = 0
#		spawn_2_beat = 2
#		spawn_3_beat = 0
#		spawn_4_beat = 2
#	if song_position_in_beats > 162:
#		spawn_1_beat = 2
#		spawn_2_beat = 2
#		spawn_3_beat = 1
#		spawn_4_beat = 1
#	if song_position_in_beats > 194:
#		spawn_1_beat = 2
#		spawn_2_beat = 2
#		spawn_3_beat = 1
#		spawn_4_beat = 2
#	if song_position_in_beats > 228:
#		spawn_1_beat = 0
#		spawn_2_beat = 2
#		spawn_3_beat = 1
#		spawn_4_beat = 2
#	if song_position_in_beats > 258:
#		spawn_1_beat = 1
#		spawn_2_beat = 2
#		spawn_3_beat = 1
#		spawn_4_beat = 2
#	if song_position_in_beats > 288:
#		spawn_1_beat = 0
#		spawn_2_beat = 2
#		spawn_3_beat = 0
#		spawn_4_beat = 2
#	if song_position_in_beats > 322:
#		spawn_1_beat = 3
#		spawn_2_beat = 2
#		spawn_3_beat = 2
#		spawn_4_beat = 1
#	if song_position_in_beats > 388:
#		spawn_1_beat = 1
#		spawn_2_beat = 0
#		spawn_3_beat = 0
#		spawn_4_beat = 0
#	if song_position_in_beats > 396:
#		spawn_1_beat = 0
#		spawn_2_beat = 0
#		spawn_3_beat = 0
#		spawn_4_beat = 0
#	if song_position_in_beats > 404:
#		



func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % 3
		instance = note.instantiate()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 3
		lane = rand
		instance = note.instantiate()
		instance.initialize(lane)
		add_child(instance)
		


func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	
	score += by * combo
	$Label.text = str(score)
	if combo > 0:
		$Combo.text = str(combo) + " combo!"
		if combo > max_combo:
			max_combo = combo
	else:
		$Combo.text = ""


func reset_combo():
	combo = 0
	$Combo.text = ""
