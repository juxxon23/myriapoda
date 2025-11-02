class_name Head
extends SnakePart

signal food_eaten
signal collide_with_tail

@onready var top: Sprite2D = %Top
@onready var coll_top: CollisionShape2D = %CollTop


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		collide_with_tail.emit()


func rotate_now(change_axis: bool) -> void:
	const horizontal: float = 90.0
	const vertical: float = 0.0
	if change_axis:
		top.rotation_degrees = vertical
		coll_top.rotation_degrees = vertical
	else:
		top.rotation_degrees = horizontal
		coll_top.rotation_degrees = horizontal


func flip_horizontal(opt: bool) -> void:
	if opt:
		top.scale.y = -1.0
	else:
		top.scale.y = 1.0


func flip_vertical(opt: bool) -> void:
	if opt:
		top.scale.y = -1.0
	else:
		top.scale.y = 1.0
