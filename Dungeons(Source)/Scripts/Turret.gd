extends Node2D

var Player_in_body : bool = false
var Player : Node
var Player_Path : NodePath
var projectile = preload("res://Scenes/Projectiles.tscn")

var force : int = 100

var dx = 688/4
var dy = 592/4

var p : RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func golem_killed():
	self.queue_free()
	pass

func shoot_projectile():
	p = projectile.instance()
	p.launch_towards()
	p.name = "pewpew"
	$PewAudio.play()
	call_deferred("add_child", p)
	pass


func _on_Timer_timeout() -> void:
	if Player_in_body:
		$Timer.start()
		shoot_projectile()
	pass # Replace with function body.


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player" || body.name == "Scrappy":
		Player_in_body = true
		Player = body
		shoot_projectile()
		$Timer.start()
	pass # Replace with function body.

func _on_Area2D_body_exited(body: Node) -> void:
	if body.name == "Player"  || body.name == "Scrappy":
		Player_in_body = false
		Player = null
	if body.name == "pewpew":
		body.queue_free()
	pass # Replace with function body.
