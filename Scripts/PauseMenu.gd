extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var song_info
	$WindowDialog.hide()# Replace with function body.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$WindowDialog.visible = !$WindowDialog.visible
		get_tree().paused = $WindowDialog.visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Resume_pressed():
	$WindowDialog.visible = !$WindowDialog.visible
	get_tree().paused = $WindowDialog.visible


func _on_Restart_pressed():
	$WindowDialog.visible = !$WindowDialog.visible
	get_tree().paused = $WindowDialog.visible
	get_tree().reload_current_scene()


func _on_QuitToMenu_pressed():
	$WindowDialog.visible = !$WindowDialog.visible
	get_tree().paused = $WindowDialog.visible
	get_tree().change_scene("res://Scenes/Menu.tscn")


func display_song_info(data:Dictionary):
	var song_name = data["song_name"]
	var song_author = data["song_author"]
	var song_album = data["song_album"]
	$Control/SongInfo.set_text("Name: %s\nAuthor: %s\nAlbum: %s" % [song_name, song_author, song_album])
	$AnimationPlayer.play("song_info")
