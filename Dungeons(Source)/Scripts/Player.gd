extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export (int) var speed = 200

var Score: int = 0
var Lives: int = 3
var velocity : Vector2 = Vector2()
var isAttacking : bool = false
var isFinish : bool = false
var Ting
var Player_Hit
var spawn_point : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isAttacking = false
	isFinish = false
	Ting = $Tingling
	Player_Hit = $Player_Hit
	make_main_camera()
	self.name = "Scrappy"
	pass # Replace with function body.


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity.length() > 0:
		$Running.set_stream_paused(false)
	if velocity.length() == 0:
		$Running.set_stream_paused(true)
	if self.Lives == 0:
		player_respawn()
	pass

func player_respawn() -> void:
	$Death.play()
	Lives = 3
	self.position = spawn_point
	pass

func get_input():
	$Sprite.visible = false
	$Help.visible = false
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$Animation.flip_h = false
		$Animation.speed_scale = 1
		pass
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$Animation.flip_h = true
		$Animation.speed_scale = 1
		pass
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		pass
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		pass
	if Input.is_action_just_pressed("ui_accept"):
		$Swoosh.play()
		$Animation.set_animation("Attack")
		isAttacking = true
		if isFinish:
			get_parent().call_deferred("resetLevel")
		pass
	if Input.is_action_pressed("ui_cancel"):
		$Help.visible = true
		pass
	if Input.is_action_pressed("ui_inv"):
		$Sprite/Lives.text = "Lives: " + str(self.Lives)
		$Sprite/Score.text = "Score: " + str(self.Score)
		$Sprite.visible = true
	velocity = velocity.normalized() * speed
	pass

func make_main_camera():
	$Camera2D.make_current()

func _on_Animation_animation_finished() -> void:
	if $Animation.get_animation() == "Attack":
		$Animation.set_animation("Idle")
		isAttacking = false
	pass


func _on_Running_finished() -> void:
	$Running.play()
	pass # Replace with function body.
