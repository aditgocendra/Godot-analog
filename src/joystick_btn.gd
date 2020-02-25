extends TouchScreenButton

var radius = Vector2(16, 16)
var boundary = 48
var on_goingdrag = -1
var return_accel = 20
var threshold = 10


func _process(delta: float) -> void:
	if on_goingdrag == -1:
		var pos_dif = (Vector2.ZERO - radius) - position
		position += pos_dif * return_accel * delta



func get_button_pos():
	return position + radius


func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()
		
		if	event_dist_from_centre <= boundary * global_scale.x or event.get_index() == on_goingdrag:
			set_global_position(event.position - radius * global_scale)
			
			if get_button_pos().length() > boundary:
				set_position(get_button_pos().normalized() * boundary - radius)

			on_goingdrag = event.get_index()
	
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == on_goingdrag:
		on_goingdrag = -1
		
		
func get_value():
	if	get_button_pos().length() > threshold:
		return get_button_pos().normalized()
		
	return Vector2.ZERO
