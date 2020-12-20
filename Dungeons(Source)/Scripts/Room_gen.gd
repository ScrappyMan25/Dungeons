extends Node
#Tile IDS

#	0	Top
#	1	Left
#	2	Bottom
#	3	Right

var Room : Node2D
var Floor : Node2D

var Player : KinematicBody2D

var dx = 688
var dy = 592
var Grid : Array = []
var Grid_Size = 3 #HAS TO BE ODD 
var corners : Array
var start
var finish

var main_path : Array
var Room_Coords : Array

var PlayerScore: int = 0
var PlayerLives: int = 0

var Rooms : Array = [
	preload("res://Assets/Rooms/1_Room_0.tscn"),#0
	preload("res://Assets/Rooms/1_Room_1.tscn"),#1
	preload("res://Assets/Rooms/1_Room_2.tscn"),#2
	preload("res://Assets/Rooms/1_Room_3.tscn"),#3
	preload("res://Assets/Rooms/2_Room_01.tscn"),#4
	preload("res://Assets/Rooms/2_Room_02.tscn"),#5
	preload("res://Assets/Rooms/2_Room_03.tscn"),#6
	preload("res://Assets/Rooms/2_Room_12.tscn"),#7
	preload("res://Assets/Rooms/2_Room_13.tscn"),#8
	preload("res://Assets/Rooms/2_Room_23.tscn"),#9
	preload("res://Assets/Rooms/3_Room_0.tscn"),#10
	preload("res://Assets/Rooms/3_Room_1.tscn"),#11
	preload("res://Assets/Rooms/3_Room_2.tscn"),#12
	preload("res://Assets/Rooms/3_Room_3.tscn"),#13
	preload("res://Assets/Rooms/4_Room.tscn")#14
]

var Floors : Array = [
	preload("res://Assets/Floors/Floor_0.tscn"),
	preload("res://Assets/Floors/Floor_1.tscn"),
	preload("res://Assets/Floors/Floor_2.tscn"),
	preload("res://Assets/Floors/Floor_3.tscn"),
	preload("res://Assets/Floors/Floor_4.tscn"),
	preload("res://Assets/Floors/Floor_5.tscn"),
	preload("res://Assets/Floors/Floor_6.tscn"),
	preload("res://Assets/Floors/Floor_7.tscn"),
	preload("res://Assets/Floors/Floor_8.tscn")
]

var Floor_start = preload("res://Assets/Floors/Floor_start.tscn")
var Floor_finish = preload("res://Assets/Floors/Floor_finish.tscn")

var Pathways : Array = [
	preload("res://Assets/PathWays/Path_Corner_01.tscn"),
	preload("res://Assets/PathWays/Path_Corner_03.tscn"),
	preload("res://Assets/PathWays/Path_Corner_12.tscn"),
	preload("res://Assets/PathWays/Path_Corner_23.tscn"),
	preload("res://Assets/PathWays/Path_Horizontal.tscn"),
	preload("res://Assets/PathWays/Path_Vertical.tscn")
]

var playerScene = preload("res://Scenes/Player.tscn")

var Rooms_01 : Array = [
	Rooms[4],
	Rooms[12],
	Rooms[13],
	Rooms[14]
] 
var Rooms_02 : Array = [
	Rooms[5],
	Rooms[11],
	Rooms[13],
	Rooms[14],
] 
var Rooms_03 : Array = [
	Rooms[6],
	Rooms[11],
	Rooms[12],
	Rooms[14],
] 
var Rooms_12 : Array = [
	Rooms[7],
	Rooms[10],
	Rooms[13],
	Rooms[14]
] 
var Rooms_13 : Array = [
	Rooms[8],
	Rooms[10],
	Rooms[12],
	Rooms[14]
] 
var Rooms_23 : Array = [
	Rooms[9],
	Rooms[10],
	Rooms[11],
	Rooms[14]
]

var Rooms_0 : Array = [
	Rooms[0],
	Rooms[4],
	Rooms[5],
	Rooms[6],
	Rooms[11],
	Rooms[12],
	Rooms[13],
	Rooms[14]
]
var Rooms_1 : Array = [
	Rooms[1],
	Rooms[4],
	Rooms[7],
	Rooms[8],
	Rooms[10],
	Rooms[12],
	Rooms[13],
	Rooms[14]
]
var Rooms_2 : Array = [
	Rooms[2],
	Rooms[5],
	Rooms[7],
	Rooms[9],
	Rooms[10],
	Rooms[11],
	Rooms[13],
	Rooms[14]
]
var Rooms_3 : Array = [
	Rooms[3],
	Rooms[6],
	Rooms[8],
	Rooms[9],
	Rooms[10],
	Rooms[11],
	Rooms[12],
	Rooms[14]
]

var Room_Dict : Dictionary ={
	"0" : Rooms_0,
	"1" : Rooms_1,
	"2" : Rooms_2,
	"3" : Rooms_3,
	
	"01" : Rooms_01,
	"10" : Rooms_01,
	
	"02" : Rooms_02,
	"20" : Rooms_02,
	
	"03" : Rooms_03,
	"30" : Rooms_03,
	
	"12" : Rooms_12,
	"21" : Rooms_12,
	
	"13" : Rooms_13,
	"31" : Rooms_13,
	
	"23" : Rooms_23,
	"32" : Rooms_23
}

var Corners_Room_dict : Dictionary = {
	Vector2(0,0) : Rooms[7],
	Vector2((Grid_Size - 1),0) : Rooms[9],
	Vector2(0,(Grid_Size - 1)) : Rooms[4],
	Vector2((Grid_Size - 1),(Grid_Size - 1)) : Rooms[6]
}

func _ready() -> void:
	randomize()
	$Camera2D.name = "cam"
	#Set BG color to 0 - Black
	VisualServer.set_default_clear_color(Color(0))
	#Room spawn deterministic grid
	createGrid()
	new_Dungeon()
	add_player() #can be in newDungeon. SHOULD BE.
	pass # Replace with function body.


#Adds the player to the Scene
func add_player():
	Player = playerScene.instance()
	Player.name = "Scrappy"
	Player.position = Vector2(((Grid_Size - 1)/2)*dx + dx/4,((Grid_Size - 1)/2)*dy +dy/4 )
	Player.spawn_point = Vector2(((Grid_Size - 1)/2)*dx + dx/4,((Grid_Size - 1)/2)*dy +dy/4 )
	Player.Score = self.PlayerScore
	add_child(Player, true)

#Variable Definitions
func define_variables():
	Rooms = [
		preload("res://Assets/Rooms/1_Room_0.tscn"),#0
		preload("res://Assets/Rooms/1_Room_1.tscn"),#1
		preload("res://Assets/Rooms/1_Room_2.tscn"),#2
		preload("res://Assets/Rooms/1_Room_3.tscn"),#3
		preload("res://Assets/Rooms/2_Room_01.tscn"),#4
		preload("res://Assets/Rooms/2_Room_02.tscn"),#5
		preload("res://Assets/Rooms/2_Room_03.tscn"),#6
		preload("res://Assets/Rooms/2_Room_12.tscn"),#7
		preload("res://Assets/Rooms/2_Room_13.tscn"),#8
		preload("res://Assets/Rooms/2_Room_23.tscn"),#9
		preload("res://Assets/Rooms/3_Room_0.tscn"),#10
		preload("res://Assets/Rooms/3_Room_1.tscn"),#11
		preload("res://Assets/Rooms/3_Room_2.tscn"),#12
		preload("res://Assets/Rooms/3_Room_3.tscn"),#13
		preload("res://Assets/Rooms/4_Room.tscn")#14
	]
	
	Rooms_01 = [
		Rooms[4],
		Rooms[12],
		Rooms[13],
		Rooms[14]
	] 
	Rooms_02 = [
		Rooms[5],
		Rooms[11],
		Rooms[13],
		Rooms[14],
	] 
	Rooms_03 = [
		Rooms[6],
		Rooms[11],
		Rooms[12],
		Rooms[14],
	] 
	Rooms_12 = [
		Rooms[7],
		Rooms[10],
		Rooms[13],
		Rooms[14]
	] 
	Rooms_13 = [
		Rooms[8],
		Rooms[10],
		Rooms[12],
		Rooms[14]
	] 
	Rooms_23 = [
		Rooms[9],
		Rooms[10],
		Rooms[11],
		Rooms[14]
	]
	
	Rooms_0 = [
		Rooms[0],
		Rooms[4],
		Rooms[5],
		Rooms[6],
		Rooms[11],
		Rooms[12],
		Rooms[13],
		Rooms[14]
	]
	Rooms_1 = [
		Rooms[1],
		Rooms[4],
		Rooms[7],
		Rooms[8],
		Rooms[10],
		Rooms[12],
		Rooms[13],
		Rooms[14]
	]
	Rooms_2 = [
		Rooms[2],
		Rooms[5],
		Rooms[7],
		Rooms[9],
		Rooms[10],
		Rooms[11],
		Rooms[13],
		Rooms[14]
	]
	Rooms_3 = [
		Rooms[3],
		Rooms[6],
		Rooms[8],
		Rooms[9],
		Rooms[10],
		Rooms[11],
		Rooms[12],
		Rooms[14]
	]

	Room_Dict ={
		"0" : Rooms_0,
		"1" : Rooms_1,
		"2" : Rooms_2,
		"3" : Rooms_3,
		
		"01" : Rooms_01,
		"10" : Rooms_01,
		
		"02" : Rooms_02,
		"20" : Rooms_02,
		
		"03" : Rooms_03,
		"30" : Rooms_03,
		
		"12" : Rooms_12,
		"21" : Rooms_12,
		
		"13" : Rooms_13,
		"31" : Rooms_13,
		
		"23" : Rooms_23,
		"32" : Rooms_23
	}

	Corners_Room_dict = {
		Vector2(0,0) : Rooms[7],
		Vector2((Grid_Size - 1),0) : Rooms[9],
		Vector2(0,(Grid_Size - 1)) : Rooms[4],
		Vector2((Grid_Size - 1),(Grid_Size - 1)) : Rooms[6]
	}
	
	Floors = [
		preload("res://Assets/Floors/Floor_0.tscn"),
		preload("res://Assets/Floors/Floor_1.tscn"),
		preload("res://Assets/Floors/Floor_2.tscn"),
		preload("res://Assets/Floors/Floor_3.tscn"),
		preload("res://Assets/Floors/Floor_4.tscn"),
		preload("res://Assets/Floors/Floor_5.tscn"),
		preload("res://Assets/Floors/Floor_6.tscn"),
		#preload("res://Assets/Floors/Floor_7.tscn"),
		#preload("res://Assets/Floors/Floor_8.tscn"),
		#preload("res://Assets/Floors/Floor_9.tscn")
	]
	pass

#CreateGrid from GridSize.
func createGrid() -> void:
	for i in Grid_Size:
		Grid.append([])
		Grid[i] = []
		for j in Grid_Size:
			Grid[i].append([])
			Grid[i][j] = Vector2(i*dx, j*dy)
	corners = [
		Grid[0][0],
		Grid[0][Grid_Size-1],
		Grid[Grid_Size-1][0],
		Grid[Grid_Size-1][Grid_Size-1]
	]
	pass

#Creates the Dungeon
func new_Dungeon() -> void:
	randomize()
	
	
	var destination : Vector2
	#Select finish Room
	corners.shuffle()
	destination = corners[0]
	build_main_path(true , destination)
	
	#Build Main Path
	for r in main_path:
		var isCorner : bool = false
		var isEdge : bool = false
		#if corners.has(r.Position):
		if (r.Position.x == 0 || r.Position.x/dx == (Grid_Size - 1)) && (r.Position.y == 0  || r.Position.y/dy == (Grid_Size - 1)):
			isCorner = true
#			print("corner")
		if r.Position.x == 0 || r.Position.y == 0 || r.Position.x/dx == (Grid_Size - 1) || r.Position.y/dy == (Grid_Size - 1):
			isEdge = true
		var status = r.Status
		var room_array = Room_Dict.get(status)
		if r.isFinish:
			Room = room_array[0].instance()
			#Room = Corners_Room_dict.get(Vector2(r.Position.x/dx, r.Position.y/dy)).instance()
			pass
		elif isCorner:
			#Pick from Pool of Corners
			Room = Corners_Room_dict.get(Vector2(r.Position.x/dx, r.Position.y/dy)).instance()
			pass
		elif isEdge:
			#Pick from Pool of Edges
#			room_array[randi() % room_array.size()]
			var temp : int
			Room = room_array[randi() % room_array.size()].instance()
			if r.Position.x == 0:
				#!3
				temp = 3
				pass
			elif r.Position.y == 0:
				#!0
				temp = 0
				pass
			elif r.Position.x/dx == (Grid_Size - 1):
				#!1
				temp = 1
				pass
			elif r.Position.y/dy == (Grid_Size - 1):
				#!2
				temp = 2
				pass
			var i = 0
			#Check if entrance Out Of Bounds Exists
			while Room.EntranceCoords.has(temp):
				Room = room_array[i].instance()
				i += 1
				pass
#			print(temp)
			pass
		else:
			Room = room_array[int(rand_range(0, room_array.size()))].instance()
		Room.position = r.Position
		Room.create_Room()
		Room_Coords.push_front(r.Position)
		add_child(Room, true)
	
	#Check For openings in Main Path and Determine Type of Room Required.
	var single_rooms = [2, 3, 0, 1]
	var NewRooms = [] 
	for n in get_children():
		if n.name.similarity("Room") > 0.5:
			#All the rooms
			for k in n.EntranceCoords.keys():
				var coords : Vector2 = Vector2()
				var spawn : bool = false
				match(k):
					0:
						coords = Vector2(n.position.x, n.position.y - dy)
						if !Room_Coords.has(coords):
							spawn = true
							pass
					1:
						coords = Vector2(n.position.x + dx, n.position.y)
						if !Room_Coords.has(coords):
							spawn = true
							pass
					2:
						coords = Vector2(n.position.x, n.position.y + dy)
						if !Room_Coords.has(coords):
							spawn = true
							pass
					3:
						coords = Vector2(n.position.x - dx, n.position.y)
						if !Room_Coords.has(coords):
							spawn = true
							pass
				if spawn:
					var d : Dictionary = {"coords" : coords, "entrance" : str(single_rooms[k])}
					var exsists = false
					if NewRooms.size()!=0:
						for i in NewRooms:
							if i.coords == d.coords && i.entrance != d.entrance:
								i.entrance += str(single_rooms[k])
								exsists = true
					if !exsists:
						NewRooms.push_back(d)
				pass
			pass
	
	#Build New Rooms
	for r in NewRooms:
		Room = Room_Dict.get(r.entrance)[0].instance()
		Room.position = r.coords
		Room.create_Room()
		add_child(Room, true)
		Room_Coords.push_front(r.coords)
	
	#using "Room_coords" Place FloorVariations AND/OR Mobs & items
	for r in Room_Coords:
		if r == start:
			#add Start Room Floor
			add_floor(1, r)
			pass
		elif r == finish:
			#add finish Room Floor
			add_floor(2, r)
			pass
		else:
			#Add NormalRoomFloor
			add_floor(0, r)
			pass
	pass

#MainPath for Dungeon - Determines Start and Finish
func build_main_path(main : bool, Dest : Vector2):
	start = Grid[(Grid_Size-1)/2][(Grid_Size-1)/2]
	var current_x : int = (Grid_Size-1)/2
	var current_y : int = (Grid_Size-1)/2
	var count_h : int = 0
	var count_v : int = 0
	
	#finish = corners[randi() % 4]
	finish = Dest
	
	count_h = (finish.x - start.x)/dx
	count_v = (finish.y - start.y)/dy
	
#	print(count_h)
#	print(count_v)
	
	var current : Dictionary = {"Position" : Grid[current_x][current_y], "Status" : "", "isFinish" : false}
	var next : Dictionary = {"Position" : null, "Status" : "", "isFinish" : false}
	
	var h_index = {-1 : "3", 1 : "1"}
	var v_index = {-1 : "0", 1 : "2"}
	
	while count_h != 0 || count_v != 0:
		randomize()
		if count_h != 0 && count_v != 0:
			#This case is when path can go vertically / horizontally
			if randf() < 0.5:
				#go horizontal
				var c_h = count_h/abs(count_h)
				current_x += c_h
				count_h -= c_h
				current.Status += h_index.get(c_h)
				next.Status = h_index.get(c_h * -1)
				pass
			else:
				#go vertical
				var c_v = count_v/abs(count_v)
				current_y += c_v
				count_v -= c_v
				current.Status += v_index.get(c_v)
				next.Status = v_index.get(c_v * -1)
				pass
			pass
		elif count_h != 0:
			#go_horizontal
			var c_h = count_h/abs(count_h)
			current_x += c_h
			count_h -= c_h
			current.Status += h_index.get(c_h)
			next.Status = h_index.get(c_h * -1)
			pass
		else:
			#go vertical
			var c_v = count_v/abs(count_v)
			current_y += c_v
			count_v -= c_v
			current.Status += v_index.get(c_v)
			next.Status = v_index.get(c_v * -1)
			pass
		
		next.Position = Grid[current_x][current_y]
		main_path.push_back(current)
		current = next.duplicate()
		next.Status = ""
		next.Position = null
		pass # end of while
	current.isFinish = main
	main_path.push_back(current)
	pass

#Adds Floor to each Room.
func add_floor(state : int, coords : Vector2) -> void:
	match(state):
		0:
			#normalroom
			randomize()
			Floors.shuffle()
			Floor = Floors[0].instance()
			Floor.position = coords
			add_child(Floor, true)
			pass
		1:
			#start
			Floor = Floor_start.instance()
			Floor.position = coords
			add_child(Floor, true)
			pass
		2:
			#finish
			Floor = Floor_finish.instance()
			Floor.position = coords
			add_child(Floor, true)
			pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_reset"):
		resetLevel()
	pass

func resetLevel():
	$SFX2.play()
	Grid_Size += 2
	PlayerScore = get_node("Scrappy").Score
	for n in get_children():
		if n.name.similarity("SFX") < 0.8:
#		if n.name != "cam":
			n.free()
	main_path.clear()
	Room_Coords.clear()
	
	createGrid()
#	corners = [
#		Grid[0][0],
#		Grid[0][Grid_Size-1],
#		Grid[Grid_Size-1][0],
#		Grid[Grid_Size-1][Grid_Size-1]
#	]
	
#	define_variables()
	new_Dungeon()
	add_player()
	
	pass
