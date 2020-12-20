extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var Player_in_body : bool = false
var Player : Node
var Animations : Array = [
	"GoldMan",
	"MushMan",
	"OgreMan",
	"WolfMan"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	Animations.shuffle()
	$AnimatedSprite.set_animation(Animations[0])
	Player_in_body = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Player_in_body && Player.isAttacking:
		Player.Ting.play()
		Player.Score += 10
		self.queue_free()
		pass
	pass


func _on_Mob_body_entered(body: Node) -> void:
	if body.name == "Player" || body.name == "Scrappy":
		Player_in_body = true
		Player = body
	pass # Replace with function body.


func _on_Mob_body_exited(body: Node) -> void:
	if body.name == "Player"  || body.name == "Scrappy":
		Player_in_body = false
		Player = null
	pass # Replace with function body.
