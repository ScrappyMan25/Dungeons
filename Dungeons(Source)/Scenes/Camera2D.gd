extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		self.position.x -= 20
		pass
	if Input.is_action_pressed("ui_right"):
		self.position.x += 20
		pass
	if Input.is_action_pressed("ui_up"):
		self.position.y -= 20
		pass
	if Input.is_action_pressed("ui_down"):
		self.position.y += 20
		pass
	if Input.is_action_just_pressed("ui_cancel"):
		self.position = Vector2(6880,0)
		pass
	if Input.is_action_just_pressed("Scroll Positive"):
		self.zoom *= 0.20
		pass
	if Input.is_action_just_pressed("Scroll Negetive"):
		self.zoom *= 2
		pass
	pass
