class_name Tail
extends SnakePart

@onready var sprite_tail: Sprite2D = %SpriteTail as Sprite2D
@onready var collision_tail: CollisionShape2D = %CollisionTail as CollisionShape2D


func _ready() -> void:
	set_head_props()


func set_head_props() -> void:
	sprite_part = sprite_tail
	collision_part = collision_tail
