extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var myseatslist = []
var mynameslist = []
var mydescriptionslist = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Firestore.connect("listed_documents", self, "_on_listed_documents")
#	Firebase.Firestore.connect("get_document", self, "_on_doc_received")
#	Firebase.Firestore.connect("error", self, "_on_error_received")
#	Firebase.Firestore.connect("add_document", self, "_on_document_added")
#	Firebase.Firestore.connect("listed_documents")
#	Firebase.Firestore.connect()
#	Firebase.Firestore.collection("/movies")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	var mymovies = Firebase.Firestore.list("movies")
	pass

func _on_listed_documents(mylist):
#	print(mylist)
	
	for doc in mylist:
#		print(doc)
		var fields = doc.doc_fields
		var itemstr = fields.name+"           :             "+fields.description
		myseatslist.append(fields.seating) 
		mynameslist.append(fields.name)
		mydescriptionslist.append(fields.description)
		$Movies.add_item(itemstr)

func _on_doc_received(doc):
	var fields = doc.doc_fields
	print(fields.name)
	print(fields.description)

func _on_error_received(code, status, message):
	print(code)
	print(status)
	print(message)

func _on_document_added(doc):
	print(doc)

func _on_doc_deleted():
	print("doc deleted")

func _on_Get_pressed():
#	var details = Firebase.Firestore.collection("movies")
##	var moviedick = {"name" : "inception",
##					"description" : "leo loves dreaming"}
#	var firstmovie = details.delete("3")
#	details.connect("delete_document", self, "_on_doc_deleted")
#	details.connect("get_document", self, "_on_doc_received")
	var mymovies = Firebase.Firestore.list("movies")
#	print(firstmovie.action)
#	_test_list()

func _test_list():
	var mylist = [{"name":"lkjsdlk", "description":"jlaksdjfakh kjahsdfjk akjdhf"},
				{"name":"lkjsdlk", "description":"jlaksdjfakh kjahsdfjk akjdhf"},
				{"name":"lkjsdlk", "description":"jlaksdjfakh kjahsdfjk akjdhf"},
				{"name":"lkjsdlk", "description":"jlaksdjfakh kjahsdfjk akjdhf"}]
	for fields in mylist:
		var itemstr = fields.name+"\t:"+fields.description
		$Movies.add_item(itemstr)
#		print(fields.name)
#		print(fields.description)
#		print()


func _on_SeatsBooker_pressed():
	Globals.docid = $Movies.get_selected_items()[0]
	Globals.seating = myseatslist[Globals.docid]
	Globals.movname = mynameslist[Globals.docid]
	Globals.description = mydescriptionslist[Globals.docid]
	get_tree().change_scene("res://booking/Seating.tscn")
