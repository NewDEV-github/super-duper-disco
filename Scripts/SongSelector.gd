extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var config_paths = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	scan_songs()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func scan_songs():
	var f = File.new()
	var d = Directory.new()
	var c = ConfigFile.new()
	if not d.dir_exists("user://saved_songs"):
		d.make_dir("user://saved_songs")
	d.open("user://saved_songs/")
	d.list_dir_begin()
	var file_name = d.get_next()
	while file_name != "":
		if not d.current_is_dir():
			c.load("user://saved_songs/" + file_name)
			add_item(c.get_value("song_data", "name"))
			config_paths[c.get_value("song_data", "name")] = "user://saved_songs/" + file_name
		file_name = d.get_next()


func _on_song_selector_item_selected(index):
	Global.current_game_config_path = config_paths[get_item_text(index)]
	get_tree().change_scene("res://Scenes/Game.tscn")
