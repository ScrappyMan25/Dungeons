extends Node

class_name Room

#Tile IDS
const Walls : Array = [0, 1, 2]
const inWalls : Array = [3, 4, 5, 6, 7, 8, 9]

const no_of_entrances = 3

const size : Vector2 = Vector2(42,36)
const Wall_coords : Array = [
	Vector2(1,0),
	Vector2(14,0),
	Vector2(20,6),
	Vector2(26,6),
	Vector2(-11,6),
	Vector2(-5,6)
]
const inWall_coords : Array = [
	Vector2(2,1),
	Vector2(15,1),
	Vector2(21,7),
	Vector2(27,7),
	Vector2(-10,7),
	Vector2(-4,7)
]
const EntranceCoords : Dictionary = {
	0: Vector2(10,-5),
	1: Vector2(31,11),
	2: Vector2(10, 29),
	3: Vector2(-11,11)
}

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
