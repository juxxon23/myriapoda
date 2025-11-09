class_name Spawner
extends Node2D

signal segment_added(segment: Segment)

@export var bounds: Bounds

var food_scene: PackedScene = preload("uid://b8o3mjaji5xvl")
var segment_scene: PackedScene = preload("uid://c1s6nrq6eqh44")


func spawn_food() -> void:
	# position to spawn it
	var spawn_point: Vector2 = Vector2.ZERO
	spawn_point.x = randf_range(bounds.x_min + Global.GRID_SIZE, bounds.x_max - Global.GRID_SIZE)
	spawn_point.y = randf_range(bounds.y_min + Global.GRID_SIZE, bounds.y_max - Global.GRID_SIZE)
	# fit in the grid
	spawn_point.x = floorf(spawn_point.x / Global.GRID_SIZE) * Global.GRID_SIZE
	spawn_point.y = floorf(spawn_point.y / Global.GRID_SIZE) * Global.GRID_SIZE
	# instantiating
	var food = food_scene.instantiate()
	food.position = spawn_point
	# parenting
	get_parent().add_child(food)


func spawn_segment(pos: Vector2) -> void:
	var segment: Segment = segment_scene.instantiate() as Segment
	segment.position = pos
	get_parent().add_child(segment)
	segment_added.emit(segment)
