class_name Head
extends SnakePart

signal food_eaten
signal collide_with_segment

@onready var sprite_head: Sprite2D = %SpriteHead
@onready var collision_head: CollisionShape2D = %CollisionHead


func _ready() -> void:
	set_head_props()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		collide_with_segment.emit()


func set_head_props() -> void:
	sprite_part = sprite_head
	collision_part = collision_head
