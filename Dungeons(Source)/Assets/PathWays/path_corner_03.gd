extends Node

const Walls : Array = [0, 1, 2]
const inWalls : Array = [3, 4, 5, 6, 7, 8, 9]
const floors : Array = [35,36,37]

const POC : Dictionary = {
	0 : Vector2(9,0),
	3 : Vector2(0,5)
}

func _ready() -> void:
	#VisualServer.set_default_clear_color(Color(0))
	#create_Room()
	pass

func create_Room() -> void:
	randomize()
	Walls.shuffle()
	inWalls.shuffle()
	floors.shuffle()
	$wall_sides.set_cell(2, 5, floors[0])
	floors.shuffle()
	$wall_sides.set_cell(8, 5, floors[0])
	
	$Wall_top.set_cell(0, 0, Walls[0])
	$Wall_top.set_cell(1, 1, inWalls[0])
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		create_Room()
	pass

