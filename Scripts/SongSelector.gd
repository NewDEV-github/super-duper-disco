extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal ready_to_play
var init_script_paths = {}
# Called when the node enters the scene tree for the first time.
func _ready():

	scan_songs()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func scan_songs():
	var av_dirs = [".", ".."]
	var f = File.new()
	var d = Directory.new()
	var c = ConfigFile.new()
	d.open(Global.install_base_path + "res/songs/")
	d.list_dir_begin()
	var file_name = d.get_next()
	while file_name != "":
		if d.current_is_dir() and not av_dirs.has(file_name):
			print(file_name)
			var base_path = Global.install_base_path + "res/songs/" + file_name
			var song_name = _get_song_data(base_path).song_name
			if _get_song_data(base_path).initialize == true:
				init_script_paths[song_name] = base_path + "/init.gd"
				add_item(song_name)
		file_name = d.get_next()
	for id in get_item_count() - 1:
		set_item_tooltip_enabled(id, false)

func _get_song_data(path):
	var s = load(path + "/init.gd").new()
	return s
func _on_song_selector_item_selected(index):
	Global.current_game_config_path = init_script_paths[get_item_text(index)]
	emit_signal("ready_to_play")
