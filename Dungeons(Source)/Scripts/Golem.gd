extends Area2D

var Player_in_body : bool = false
var Player : Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Player_in_body = false
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if Player_in_body && Player.isAttacking:
		Player.Ting.play()
		Player.Score += 20
		get_parent().golem_killed()
		self.queue_free()
		pass
	pass


func _on_Golem_body_entered(body: Node) -> void:
	if body.name == "Player" || body.name == "Scrappy":
		Player_in_body = true
		Player = body
	pass # Replace with function body.


func _on_Golem_body_exited(body: Node) -> void:
	if body.name == "Player"  || body.name == "Scrappy":
		Player_in_body = false
		Player = null
	pass # Replace with function body.
