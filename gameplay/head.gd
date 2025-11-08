class_name Head
extends SnakePart

signal food_eaten
signal collide_with_tail

@onready var top: Sprite2D = %Top as Sprite2D
@onready var coll_top: CollisionShape2D = %CollTop as CollisionShape2D


func _ready() -> void:
	set_head_props()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		collide_with_tail.emit()


func set_head_props() -> void:
	sprite_part = top
	collision_part = coll_top
