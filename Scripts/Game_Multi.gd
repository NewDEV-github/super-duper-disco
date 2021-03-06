extends Control

var score = 0
var score_p2 = 0
var score_p1 = 0
var combo = 0
var combo_p1 = 0
var combo_p2 = 0
var notes_spawn = {}
var notes_spawn_multi_1 = {}
var notes_spawn_multi_2 = {}
var max_combo_p1 = 0
var max_combo_p2 = 0
var great_p2 = 0
var good_p2 = 0
var okay_p2 = 0
var missed_p2 = 0
var great_p1 = 0
var good_p1 = 0
var okay_p1 = 0
var missed_p1 = 0
var end_song_position = 0
var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0


var spawn_1_beat_p1 = 0
var spawn_2_beat_p1 = 0
var spawn_3_beat_p1 = 1
var spawn_4_beat_p1 = 0

var spawn_1_beat_p2 = 0
var spawn_2_beat_p2 = 0
var spawn_3_beat_p2 = 1
var spawn_4_beat_p2 = 0


var lane = 0
var rand = 0
var note = load("res://Scenes/Note.tscn")
var instance
var instance2

func _ready():
	get_tree().paused = false
	$AnimationPlayer.play("intro")
	yield($AnimationPlayer, "animation_finished")
	if Global.enable_combo:
		$PlayersUI/Player1/combo_and_score/combo_p1.show()
		$PlayersUI/Player2/combo_and_score/combo_p2.show()
	else:
		$PlayersUI/Player1/combo_and_score/combo_p1.show()
		$PlayersUI/Player2/combo_and_score/combo_p2.hide()
	randomize()
	if Global.current_game_config_path != "NA":
		load_song(Global.current_game_config_path)

#
#func _input(event):
#	if event.is_action_pressed("go_to_end_test"): #Shift + Ctrl + Alt + E
#		Global.set_score_p1(score_p1)
#		Global.set_score_p2(score_p2)
#		Global.combo_p1 = max_combo_p1
#		Global.combo_p2 = max_combo_p2
#		Global.great_p1 = great_p1
#		Global.great_p2 = great_p2
#		Global.good_p1 = good_p2
#		Global.good_p2 = good_p2
#		Global.okay_p1 = okay_p1
#		Global.okay_p2 = okay_p2
#		Global.missed_p1 = missed_p1
#		Global.missed_p2 = missed_p2
#		if get_tree().change_scene("res://Scenes/End_Multi.tscn") != OK:
#			print("Error changing scene to End")
func load_song(script_path:String):
	var s = load(script_path).new()
	$Conductor.bpm = s.bpm
	$Conductor.measures = s.measures #MAX 4
	$Conductor.stream = ParseAudioAsStreamData(Global.install_base_path + s.song_file_path)
	notes_spawn = s.notes_spawn
	notes_spawn_multi_1 = s.notes_spawn_multi_1
	notes_spawn_multi_2 = s.notes_spawn_multi_2
	end_song_position = int(s.end_song_position)
	var data = {"song_name": s.song_name, "song_author": s.song_author, "song_album": s.song_album}
	$CanvasLayer.display_song_info(data)
	$Conductor.play_with_beat_offset(s.play_offset)

func _on_Conductor_measure(position):
	if Global.multi_game_mode == Global.MultiGameModes.SeparatedNotes:
			if position == 1:
				_spawn_notes(spawn_1_beat_p1, 1)
				_spawn_notes(spawn_1_beat_p2, 2)
			elif position == 2:
				_spawn_notes(spawn_2_beat_p1, 1)
				_spawn_notes(spawn_2_beat_p2, 2)
			elif position == 3:
				_spawn_notes(spawn_3_beat_p1, 1)
				_spawn_notes(spawn_3_beat_p2, 2)
			elif position == 4:
				_spawn_notes(spawn_4_beat_p1, 1)
				_spawn_notes(spawn_4_beat_p2, 2)
	else:
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
#	$Position.text = "Song position: " + str(position)
	song_position_in_beats = position
	for i in notes_spawn:
#		print(notes_spawn[i])
		
		if song_position_in_beats >= int(i):
			if int(i) == int(end_song_position):
				Global.set_score_p1(score_p1)
				Global.set_score_p2(score_p2)
				Global.combo_p1 = max_combo_p1
				Global.combo_p2 = max_combo_p2
				Global.great_p1 = great_p1
				Global.great_p2 = great_p2
				Global.good_p1 = good_p2
				Global.good_p2 = good_p2
				Global.okay_p1 = okay_p1
				Global.okay_p2 = okay_p2
				Global.missed_p1 = missed_p1
				Global.missed_p2 = missed_p2
				if get_tree().change_scene("res://Scenes/End_Multi.tscn") != OK:
					print("Error changing scene to End")
			else:
				if Global.multi_game_mode == Global.MultiGameModes.SeparatedNotes:
					spawn_1_beat_p1 = int(notes_spawn_multi_1[i]["spawn_1_beat"])
					spawn_2_beat_p1 = int(notes_spawn_multi_1[i]["spawn_2_beat"])
					spawn_3_beat_p1 = int(notes_spawn_multi_1[i]["spawn_3_beat"])
					spawn_4_beat_p1 = int(notes_spawn_multi_1[i]["spawn_4_beat"])
					spawn_1_beat_p2 = int(notes_spawn_multi_2[i]["spawn_1_beat"])
					spawn_2_beat_p2 = int(notes_spawn_multi_2[i]["spawn_2_beat"])
					spawn_3_beat_p2 = int(notes_spawn_multi_2[i]["spawn_3_beat"])
					spawn_4_beat_p2 = int(notes_spawn_multi_2[i]["spawn_4_beat"])
				else:
					spawn_1_beat = int(notes_spawn[i]["spawn_1_beat"])
					spawn_2_beat = int(notes_spawn[i]["spawn_2_beat"])
					spawn_3_beat = int(notes_spawn[i]["spawn_3_beat"])
					spawn_4_beat = int(notes_spawn[i]["spawn_4_beat"])
					


func _spawn_notes(to_spawn, player_number:int=0):
	match Global.multi_game_mode:
		Global.MultiGameModes.RandomizedNotes:
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var player = rng.randi_range(0,2) #random player, haha
		#	print(player)
			if to_spawn > 0:
				lane = randi() % 3
				instance = note.instance()
				instance.initialize(lane, player)
				add_child(instance)
			elif to_spawn > 1:
				while rand == lane:
					rand = randi() % 3
				lane = rand
				instance = note.instance()
				instance.initialize(lane, player)
				add_child(instance)
		Global.MultiGameModes.DuplicatedNotes:
			if to_spawn > 0:
				lane = randi() % 3
				instance = note.instance()
				instance.initialize(lane, 1)
				add_child(instance)
				instance2 = note.instance()
				instance2.initialize(lane, 2)
				add_child(instance2)
			elif to_spawn > 1:
				while rand == lane:
					rand = randi() % 3
				lane = rand
				instance = note.instance()
				instance.initialize(lane, 1)
				add_child(instance)
				instance2 = note.instance()
				instance2.initialize(lane, 2)
				add_child(instance2)
		Global.MultiGameModes.SeparatedNotes:
			if to_spawn > 0:
				lane = randi() % 3
				instance = note.instance()
				instance.initialize(lane, player_number)
				add_child(instance)
				instance2 = note.instance()
				instance2.initialize(lane, player_number)
				add_child(instance2)
			elif to_spawn > 1:
				while rand == lane:
					rand = randi() % 3
				lane = rand
				instance = note.instance()
				instance.initialize(lane, player_number)
				add_child(instance)
				instance2 = note.instance()
				instance2.initialize(lane, player_number)
				add_child(instance2)


func increment_score(by, player_number:int=0):
	if by > 0:
		if player_number ==1:
			combo_p1 += 1
		elif player_number ==2:
			combo_p2 += 1
#		combo += 1
	else:
		combo_p1 = 0
		combo_p2 = 0
	print(player_number)
	if player_number == 1:
		if by == 3:
			great_p1 += 1
		elif by == 2:
			good_p1 += 1
		elif by == 1:
			okay_p1 += 1
		else:
			missed_p1 += 1
	elif player_number == 2:
		if by == 3:
			great_p2 += 1
		elif by == 2:
			good_p2 += 1
		elif by == 1:
			okay_p2 += 1
		else:
			missed_p2 += 1
	if player_number == 0:
		score += by * combo
		$Label.text = str(score)
	elif player_number == 1:
		score_p1 += by *combo_p1
		$PlayersUI/Player1/combo_and_score/score_p1.text = str(score_p1)
	elif player_number == 2:
		score_p2 += by*combo_p2
		$PlayersUI/Player2/combo_and_score/score_p2.text = str(score_p2)
	if combo_p1 > 0 and Global.enable_combo:
		$PlayersUI/Player1/combo_and_score/combo_p1.text = str(combo_p1) + " combo!"
		if combo_p1 > max_combo_p1:
			max_combo_p1 = combo_p1
	else:
		$PlayersUI/Player1/combo_and_score/combo_p1.text = ""
	if combo_p2 > 0 and Global.enable_combo:
		$PlayersUI/Player2/combo_and_score/combo_p2.text = str(combo_p2) + " combo!"
		if combo_p2 > max_combo_p2:
			max_combo_p2 = combo_p2
	else:
#		$Combo.text = ""
		$PlayersUI/Player2/combo_and_score/combo_p2.text = ""


func reset_combo(player:int=0):
	if player == 0:
		combo = 0
	elif player == 1:
		combo_p1 = 0
		$PlayersUI/Player1/combo_and_score/combo_p1.text = ""
	elif player == 2:
		combo_p2 = 0
		$PlayersUI/Player2/combo_and_score/combo_p2.text = ""

func ParseAudioAsStreamData(filepath):
	print("AUDIO AT: " + filepath)
	var file = File.new()
	var err = file.open(filepath, File.READ)
	if err != OK:
		report_errors(err, filepath)
		file.close()
		return AudioStreamSample.new()

	var bytes = file.get_buffer(file.get_len())

	# if File is wav
	if filepath.ends_with(".wav"):

		var newstream = AudioStreamSample.new()

		#---------------------------
		#parrrrseeeeee!!! :D

		for i in range(0, 100):
			var those4bytes = str(char(bytes[i])+char(bytes[i+1])+char(bytes[i+2])+char(bytes[i+3]))

			if those4bytes == "RIFF": 
				print ("RIFF OK at bytes " + str(i) + "-" + str(i+3))
				#RIP bytes 4-7 integer for now
			if those4bytes == "WAVE": 
				print ("WAVE OK at bytes " + str(i) + "-" + str(i+3))

			if those4bytes == "fmt ":
				print ("fmt OK at bytes " + str(i) + "-" + str(i+3))

				#get format subchunk size, 4 bytes next to "fmt " are an int32
				var formatsubchunksize = bytes[i+4] + (bytes[i+5] << 8) + (bytes[i+6] << 16) + (bytes[i+7] << 24)
				print ("Format subchunk size: " + str(formatsubchunksize))

				#using formatsubchunk index so it's easier to understand what's going on
				var fsc0 = i+8 #fsc0 is byte 8 after start of "fmt "

				#get format code [Bytes 0-1]
				var format_code = bytes[fsc0] + (bytes[fsc0+1] << 8)
				var format_name
				if format_code == 0: format_name = "8_BITS"
				elif format_code == 1: format_name = "16_BITS"
				elif format_code == 2: format_name = "IMA_ADPCM"
				print ("Format: " + str(format_code) + " " + format_name)
				#assign format to our AudioStreamSample
				newstream.format = format_code

				#get channel num [Bytes 2-3]
				var channel_num = bytes[fsc0+2] + (bytes[fsc0+3] << 8)
				print ("Number of channels: " + str(channel_num))
				#set our AudioStreamSample to stereo if needed
				if channel_num == 2: newstream.stereo = true

				#get sample rate [Bytes 4-7]
				var sample_rate = bytes[fsc0+4] + (bytes[fsc0+5] << 8) + (bytes[fsc0+6] << 16) + (bytes[fsc0+7] << 24)
				print ("Sample rate: " + str(sample_rate))
				#set our AudioStreamSample mixrate
				newstream.mix_rate = sample_rate

				#get byte_rate [Bytes 8-11] because we can
				var byte_rate = bytes[fsc0+8] + (bytes[fsc0+9] << 8) + (bytes[fsc0+10] << 16) + (bytes[fsc0+11] << 24)
				print ("Byte rate: " + str(byte_rate))

				#same with bits*sample*channel [Bytes 12-13]
				var bits_sample_channel = bytes[fsc0+12] + (bytes[fsc0+13] << 8)
				print ("BitsPerSample * Channel / 8: " + str(bits_sample_channel))

				#aaaand bits per sample/bitrate [Bytes 14-15] - TODO: Handle different bitrates
				var bits_per_sample = bytes[fsc0+14] + (bytes[fsc0+15] << 8)
				print ("Bits per sample: " + str(bits_per_sample))


			if those4bytes == "data":
				var audio_data_size = bytes[i+4] + (bytes[i+5] << 8) + (bytes[i+6] << 16) + (bytes[i+7] << 24)
				print ("Audio data/stream size is " + str(audio_data_size) + " bytes")

				var data_entry_point = (i+8)
				print ("Audio data starts at byte " + str(data_entry_point))

				newstream.data = bytes.subarray(data_entry_point, data_entry_point+audio_data_size-1)

			# end of parsing
			#---------------------------

		#get samples and set loop end
		var samplenum = newstream.data.size() / 4
		newstream.loop_end = samplenum
		newstream.loop_mode = 1 #change to 0 or delete this line if you don't want loop, also check out modes 2 and 3 in the docs
		return newstream  #:D

	#if file is ogg
	elif filepath.ends_with(".ogg"):
		var newstream = AudioStreamOGGVorbis.new()
		newstream.loop = true #set to false or delete this line if you don't want to loop
		newstream.data = bytes
		return newstream

	#if file is mp3
	elif filepath.ends_with(".mp3"):
		var newstream = AudioStreamMP3.new()
		newstream.loop = true #set to false or delete this line if you don't want to loop
		newstream.data = bytes
		return newstream

	else:
		print ("ERROR: Wrong filetype or format")
	file.close()
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
		ERR_FILE_EOF: "File: End of file (EOF) error.",
		ERR_FILE_NO_PERMISSION: "Ruski okrecie, idi na hui"
	}
	if err in result_hash:
		print("Error: ", result_hash[err], " ", filepath)
	else:
		print("Unknown error with file ", filepath, " error code: ", err)



