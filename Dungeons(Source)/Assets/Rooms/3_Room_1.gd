extends Node

#Tile IDS
const Walls : Array = [0, 1, 2]
const inWalls : Array = [3, 4, 5, 6, 7, 8, 9]

const no_of_entrances = 3

const corner : Vector2 = Vector2(-11,-6)
const size : Vector2 = Vector2(31,35)

const Wall_coords : Array = [
	Vector2(1,0),
	Vector2(14,0),
	Vector2(-11,6),
	Vector2(-5,6)
]
const inWall_coords : Array = [
	Vector2(2,1),
	Vector2(15,1),
	Vector2(-10,7),
	Vector2(-4,7)
]
const EntranceCoords : Dictionary = {
	0: Vector2(10,-5),
	#1: Vector2(31,11),
	2: Vector2(10, 29),
	3: Vector2(-11,11)
}

func _ready() -> void:
	#VisualServer.set_default_clear_color(Color(0))
	#create_Room()
	pass
	
func create_Room() -> void:
	for w in Wall_coords:
		randomize()
		Walls.shuffle()
		$Wall_top.set_cell(w.x, w.y, Walls[0])
		pass
	for w in inWall_coords:
		inWalls.shuffle()
		$Wall_top.set_cell(w.x, w.y, inWalls[0])
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("ui_accept"):
#		create_Room()
#	pass
