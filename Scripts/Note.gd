extends Area2D

const TARGET_Y = 164
const SPAWN_Y = -16
const DIST_TO_TARGET = TARGET_Y - SPAWN_Y

const LEFT_LANE_SPAWN = Vector2(120, SPAWN_Y)
const CENTRE_LANE_SPAWN = Vector2(160, SPAWN_Y)
const RIGHT_LANE_SPAWN = Vector2(200, SPAWN_Y)
const LEFT_LANE_SPAWN_MULTI_P1 = Vector2(50, SPAWN_Y)
const LEFT_LANE_SPAWN_MULTI_P2 = Vector2(195, SPAWN_Y)
const RIGHT_LANE_SPAWN_MULTI_P1 = Vector2(130, SPAWN_Y)
const RIGHT_LANE_SPAWN_MULTI_P2 = Vector2(276, SPAWN_Y)
const CENTRE_LANE_SPAWN_MULTI_P1 = Vector2(90, SPAWN_Y)
const CENTRE_LANE_SPAWN_MULTI_P2 = Vector2(236, SPAWN_Y)

var speed = 0
var hit = false


func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position.y += speed * delta
		if position.y > 200:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.y -= speed * delta


func initialize(lane, player:int=0): #player number, leave 0 if not multi
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
