extends CharacterBody2D


var velocity = Vector2()
var move_direction = Vector2()

var SPEED = 30


func _physics_process(delta):
	_process_input()
	velocity = move_direction * SPEED
	move_and_slide()


func _process_input():
	move_direction = Vector2()
	if Input.is_action_pressed("ui_up"):
		move_direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		move_direction.y += 1
	if Input.is_action_pressed("ui_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		move_direction.x += 1
	move_direction = move_direction.normalized()
