extends RigidBody2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func launch_towards():
	add_central_force(Vector2(randf() - 0.5, randf() - 0.5).normalized() * 150)
	

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Scrappy":
		body.Lives -= 1
		body.Player_Hit.play()
		self.queue_free()
	pass # Replace with function body.

func _on_Timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.
