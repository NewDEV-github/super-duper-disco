extends VideoPlayer        

func _ready(): #{           
	set_process(true)
#}

func _process(delta): #{
	if is_playing() ==false:
		play()
#}
