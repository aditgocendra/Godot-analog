extends KinematicBody2D


onready var joy = get_parent().get_node("Joystick/joystick_btn") 
var velocity


func _process(delta):
	velocity =  move_and_slide(joy.get_value() * 800)
	print(velocity)
