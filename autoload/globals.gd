extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var seating
var docid
var movname
var description
var seats_chosen = []
# Called when the node enters the scene tree for the first time.
func _ready():
	seating = [
	"00000000 00000000",
	"00011110 00111111",
	"01100000 00000000",
	"00000000 00000000",
	"00111000 00000000",
	"00000000 00000000",
	"00000000 00000000",
	"00000000 00000000",
	]
	movname = ""
	description = ""
	docid = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
