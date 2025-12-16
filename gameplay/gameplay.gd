class_name Gameplay
extends Node2D

const gameover_scene:  PackedScene = preload("uid://mdfrrnsaukcp")
const pausemenu_scene:  PackedScene = preload("uid://bpankxymenwob")
const BASIC_SPEED: float = 5000.0 

@onready var head: Head = %Head as Head # 'as Head' helps with the autocomplete of Head's functions
@onready var bounds: Bounds = %Bounds as Bounds
@onready var spawner: Spawner = $Spawner as Spawner
@onready var hud: HUD = %HUD as HUD
@onready var segment: Segment = %Segment as Segment
@onready var tail: Area2D = %Tail as Tail
@onready var dash_timer: Timer = %DashTimer as Timer

var time_between_moves: float = 1000.0
var time_since_last_move: float = 0
var speed: float = BASIC_SPEED
var speed_accumulation: float = 0.0
var move_dir: Vector2 = Vector2.RIGHT
var snake_parts: Array[SnakePart] = []
var create_elbow: bool = false
var gameover_menu: GameOver
var pause_menu: PauseMenu
var score: int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(value)


func _ready() -> void:
	head.food_eaten.connect(_on_food_eaten)
	head.collide_with_segment.connect(_on_segment_collide)
	spawner.segment_added.connect(_on_segment_added)
	time_since_last_move = time_between_moves
	spawner.spawn_food()
	snake_parts.push_back(head)
	snake_parts.push_back(segment)
	snake_parts.push_back(tail)


func _process(_delta: float) -> void:
	var new_dir: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		new_dir = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		new_dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_right"):
		new_dir = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		new_dir = Vector2.LEFT
		
	# Don't allow reverse directions
	if new_dir + move_dir != Vector2.ZERO and new_dir != Vector2.ZERO:
		move_dir = new_dir
		head.rotate_part(move_dir)
		head.first_position = head.position
		create_elbow = true
		
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
	if Input.is_action_just_pressed("ui_dash"):
		dash_timer.start()
		speed = speed * 5


func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_snake()
		time_since_last_move = 0


func update_snake() -> void:
	var new_pos: Vector2 = head.position + move_dir * Global.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	head.move_to(new_pos)
	
	for i in range(1, snake_parts.size(), 1):
		if i == snake_parts.size()-2:
			snake_parts[i].penultimate_position = snake_parts[i-1].last_position
		snake_parts[i].move_to(snake_parts[i-1].last_position)
		if create_elbow and snake_parts[i].position == head.first_position :
			snake_parts[i].rotate_part(move_dir)


func _on_food_eaten() -> void:
	spawner.call_deferred("spawn_food")
	spawner.call_deferred("spawn_segment", snake_parts[snake_parts.size()-2].penultimate_position)
	speed_accumulation += 500.0
	speed += 500.0
	score += 1

	
func _on_segment_added(new_segment: Segment) -> void:
	snake_parts.insert(snake_parts.size()-2, new_segment)  # penultimate position, add segment before tail


func _on_segment_collide() -> void:
	if not gameover_menu:
		gameover_menu = gameover_scene.instantiate() as GameOver
		add_child(gameover_menu)
		gameover_menu.set_score(score)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()


func pause_game() -> void:
	if not pause_menu:
		pause_menu = pausemenu_scene.instantiate() as PauseMenu
		add_child(pause_menu)


func _on_dash_timer_timeout() -> void:
	speed = BASIC_SPEED + speed_accumulation
