extends CharacterBody2D

enum State {SIT, HOVER, DRAG}

@onready var sprite = $Sprite2D
var my_state = State.SIT


func _process(delta):
	if Input.is_action_just_pressed("input_left_click") and my_state == State.HOVER:
		my_state = State.DRAG
		sprite.set_rotation_degrees(-10)
	if Input.is_action_just_released("input_left_click"):
		my_state = State.SIT
		sprite.set_rotation_degrees(0)
	
	if my_state == State.DRAG:
		var offset = get_global_mouse_position() - get_position()
		position += offset


func _on_mouse_entered():
	sprite.set_scale(Vector2(0.6, 0.6))
	if my_state == State.SIT:
		my_state = State.HOVER


func _on_mouse_exited():
	sprite.set_scale(Vector2(0.5, 0.5))
	if my_state == State.HOVER:
		my_state = State.SIT
