extends Node2D


func _ready():
	Firebase.Auth.connect("signup_succeeded", self, "_on_signup_success")
	Firebase.Auth.connect("login_failed", self, "_on_signup_failure")
	Firebase.Auth.connect("login_succeeded", self, "_on_login_success")
	email_signup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func email_signup():
#	Firebase.Auth.signup_with_email(email, password)
	pass


func _on_Signup_pressed():
	var email = $Email.text
	var password = $Password.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	
func _on_signup_success(auth_result):
	$Error.text = "signup successful"

func _on_signup_failure(code, message):
	$Error.text = "signup failed : " + message
	print(code)
	print("--------------------------------------------------------------------------------")
	print(message)

func _on_login_success(auth_result):
	$Error.text = "login successful"
	get_tree().change_scene("res://movie/Node2D.tscn")

func _on_Login_pressed():
	var email = $Email.text
	var password = $Password.text
	Firebase.Auth.login_with_email_and_password(email, password)
