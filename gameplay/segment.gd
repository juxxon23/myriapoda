class_name Segment
extends SnakePart

@onready var sprite_segment: Sprite2D = %SpriteSegment as Sprite2D
@onready var collision_segment: CollisionShape2D = %CollisionSegment as CollisionShape2D


func _ready() -> void:
	set_head_props()


func set_head_props() -> void:
	sprite_part = sprite_segment
	collision_part = collision_segment
