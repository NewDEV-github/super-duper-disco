extends VideoPlayer        

func _ready(): #{           
	set_process(true)
#}

func _process(delta): #{
	if is_playing() ==false:
		randomize()
		var proto_modes = ["left", "right", "none"]
		var random_item = proto_modes[randi() % proto_modes.size()]
		if not random_item == "none":
			$AnimationPlayer.play("protogen_" + random_item)
		play()
