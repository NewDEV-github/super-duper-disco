extends EditorExportPlugin


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _export_begin(features, is_debug, path:String, flags):
	print("Exporting to path: " +path.get_base_dir())
	var files = get_all_song_files('res://res/songs')
	for i in files:
		var splitted_path = str(i).split("/")
		splitted_path.remove(0)
		splitted_path.remove(0)
		var compiled_path = splitted_path.join('/')
		var dest_path = path.get_base_dir() + "/" + compiled_path
		var dir = Directory.new()
		print("[SongExport] Checking if song export dir exists...")
		if not dir.dir_exists(str(dest_path).get_base_dir()):
			print("[SongExport] Song export dir doesn't exist, creating new one at: " + str(dest_path).get_base_dir())
			dir.make_dir_recursive(str(dest_path).get_base_dir())
		else:
			print("[SongExport] Song export dir exists at: " + str(dest_path).get_base_dir())
		print("[SongExport] Copying %s => %s" % [splitted_path[splitted_path.size() -1], dest_path])
		dir.copy(i, dest_path)

func get_all_song_files(path: String, file_ext := "", files := []):
	var dir = Directory.new()

	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)

		var file_name = dir.get_next()

		while file_name != "":
			if dir.current_is_dir():
				files = get_all_song_files(dir.get_current_dir().plus_file(file_name), file_ext, files)
			else:
				if file_ext and file_name.get_extension() != file_ext:
					file_name = dir.get_next()
					continue

				files.append(dir.get_current_dir().plus_file(file_name))

			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access %s." % path)

	return files
