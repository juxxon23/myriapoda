extends Node

#Display (25:14)
const GRID_SIZE: int = 32

var save_data: SaveData

func _ready() -> void:
	save_data = SaveData.load_or_create()
