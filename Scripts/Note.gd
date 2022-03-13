extends Area2D
const DIE_POSIITON_Y = 590
const TARGET_Y = 540
const SPAWN_Y = -16
const DIST_TO_TARGET = TARGET_Y - SPAWN_Y

const LEFT_LANE_SPAWN = Vector2(433, SPAWN_Y)
const CENTRE_LANE_SPAWN = Vector2(513, SPAWN_Y)
const RIGHT_LANE_SPAWN = Vector2(592, SPAWN_Y)
const LEFT_LANE_SPAWN_MULTI_P1 = Vector2(181, SPAWN_Y)
const LEFT_LANE_SPAWN_MULTI_P2 = Vector2(690, SPAWN_Y)
const RIGHT_LANE_SPAWN_MULTI_P1 = Vector2(340, SPAWN_Y)
const RIGHT_LANE_SPAWN_MULTI_P2 = Vector2(850, SPAWN_Y)
const CENTRE_LANE_SPAWN_MULTI_P1 = Vector2(260, SPAWN_Y)
const CENTRE_LANE_SPAWN_MULTI_P2 = Vector2(770, SPAWN_Y)
var note_player = 0
var speed = 0
var hit = false


func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position.y += speed * delta
		if position.y > DIE_POSIITON_Y:
			queue_free()
			get_parent().reset_combo(note_player)
	else:
		$Node2D.position.y -= speed * delta


func initialize(lane, player:int=0): #player number, leave 0 if not multi
	note_player = player
	print("Note player:" + str(player))
	if Global.multi_mode:
		if lane == 0:
			$AnimatedSprite.frame = 0
			if player == 1:
				position = LEFT_LANE_SPAWN_MULTI_P1
			else:
				position = LEFT_LANE_SPAWN_MULTI_P2
		elif lane == 1:
			$AnimatedSprite.frame = 1
			if player == 1:
				position = CENTRE_LANE_SPAWN_MULTI_P1
			else:
				position = CENTRE_LANE_SPAWN_MULTI_P2
		elif lane == 2:
			$AnimatedSprite.frame = 2
			if player == 1:
				position = RIGHT_LANE_SPAWN_MULTI_P1
			else:
				position = RIGHT_LANE_SPAWN_MULTI_P2
		else:
			printerr("Invalid lane set for note: " + str(lane))
			return
	else:
		if lane == 0:
			$AnimatedSprite.frame = 0
			position = LEFT_LANE_SPAWN
		elif lane == 1:
			$AnimatedSprite.frame = 1
			position = CENTRE_LANE_SPAWN
		elif lane == 2:
			$AnimatedSprite.frame = 2
			position = RIGHT_LANE_SPAWN
		else:
			printerr("Invalid lane set for note: " + str(lane))
			return
	speed = DIST_TO_TARGET / 2.0


func destroy(score):
#	$CPUParticles2D.emitting = true
#	$AnimatedSprite.visible = false
	$AnimatedSprite.queue_free()
	$CollisionShape2D.queue_free()
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "GREAT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")


func _on_Timer_timeout():
	queue_free()
