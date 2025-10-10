class_name Head
extends SnakePart

signal food_eaten
signal collide_with_tail

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		collide_with_tail.emit()
