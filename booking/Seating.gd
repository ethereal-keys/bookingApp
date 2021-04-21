extends Node2D


var Chair = preload("res://booking/Chair.tscn")
enum{
	EMPTY,
	RESERVED,
	BOOKED
}

var alpha = ['A','B','C','D','E','F','G','H','I']
var seating
var chosen_seats = []

func _ready():
	seating = Globals.seating
	for row in range(len(seating)):
		for seat in range(seating[row].length()):
			match seating[row][seat]:
				"1": make_chair(seat, row, RESERVED)
				"0": make_chair(seat, row, EMPTY)

func make_chair(col, row, state):
	var chair = Chair.instance()
	chair.initialize(state)
	chair.position.x = col * 50
	chair.position.y = row * 50
	chair.connect("selected", self, "_on_chair_selected")
	chair.connect("unselected", self, "_on_chair_unselected")
	$Rows.add_child(chair)

func _on_chair_selected(curchair):
	var row = curchair.position.y/50
	var col = curchair.position.x/50
	seating[row][col] = "1"
	chosen_seats.append(alpha[row]+str(col+1))

func _on_chair_unselected(curchair):
	var row = curchair.position.y/50
	var col = curchair.position.x/50
	seating[row][col] = "0"
	chosen_seats.erase(alpha[row]+str(col+1))

func _on_doc_updated(doc):
	print(doc)
	Globals.seats_chosen = chosen_seats
	get_tree().change_scene("res://confirm/Ticket.tscn")

func _on_Confirm_pressed():
	if len(chosen_seats) == 0:
		$Error.visible = true
		return
	var movieupdate = {
		"name" : Globals.movname,
		"description" : Globals.description,
		"seating" : seating
	}
	var details = Firebase.Firestore.collection("movies")
	details.connect("update_document", self, "_on_doc_updated")
	var firetaskthingy = details.update(str(Globals.docid+1), movieupdate)
	
	pass # Replace with function body.
