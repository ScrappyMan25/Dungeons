extends Node2D

var Player_in_body : bool = false
var Player : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player_in_body = false
	$Sprite.visible = false
	$Label.visible = false
	pass # Replace with function body.


func _on_Mob_body_entered(body: Node) -> void:
	if body.name == "Player" || body.name == "Scrappy":
		Player = body
		Player_in_body = true
		Player.isFinish = true
		$Sprite.visible = true
		$Label.visible = true
	pass # Replace with function body.


func _on_Mob_body_exited(body: Node) -> void:
	if body.name == "Player"  || body.name == "Scrappy":
		Player.isFinish = false
		Player_in_body = false
		$Sprite.visible = false
		$Label.visible = false
		Player = null
	pass # Replace with function body.
