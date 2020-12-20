extends Node

const Walls : Array = [0, 1, 2]
const inWalls : Array = [3, 4, 5, 6, 7, 8, 9]

const POC : Vector2 = Vector2(2,0)


func _ready() -> void:
	#VisualServer.set_default_clear_color(Color(0))
	#create_Room()
	pass

func create_Room():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("ui_accept"):
#		create_Room()
#	pass
