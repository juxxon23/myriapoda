class_name SnakePart
extends Area2D

var penultimate_position: Vector2
var last_position: Vector2
var sprite_part: Sprite2D
var collision_part: CollisionShape2D


func move_to(new_position: Vector2) -> void:
	last_position = self.position
	self.position = new_position


func rotate_part(move_dir: Vector2) -> void:
	const horizontal: float = 90.0
	const vertical: float = 0.0
	const up_or_right: float = 1.0
	const down_or_left: float = -1.0
	match move_dir:
		Vector2.UP:
			rotate_now(vertical)
			flip_now(up_or_right)
		Vector2.DOWN:
			rotate_now(vertical)
			flip_now(down_or_left)
		Vector2.RIGHT:
			rotate_now(horizontal)
			flip_now(up_or_right)
		Vector2.LEFT:
			rotate_now(horizontal)
			flip_now(down_or_left)
		_: return


func rotate_now(change_axis: float) -> void:
	sprite_part.rotation_degrees = change_axis
	collision_part.rotation_degrees = change_axis


func flip_now(opt: float) -> void:
	sprite_part.scale.y = opt
