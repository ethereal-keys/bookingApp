extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum{
	EMPTY,
	RESERVED,
	BOOKED
}

var state = EMPTY
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
signal selected
signal unselected
#func _init(seatstate):
#	state = seatstate

func initialize(seatstate):
	state = seatstate
	match state:
		EMPTY: $Empty.visible = true
		RESERVED: $Reserved.visible = true
		BOOKED: $Booked.visible = true

func _on_Button_pressed():
	if state == EMPTY:
		$Booked.visible = true
		$Empty.visible = false
		state = BOOKED
		emit_signal("selected", self)
	elif state == BOOKED:
		$Booked.visible = false
		$Empty.visible = true
		state = EMPTY
		emit_signal("unselected", self)
