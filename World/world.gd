extends Node

func _ready() -> void:
	$Player.add_skill(load(consts.path_to_shoot), 0)


func _on_player_player_died() -> void:
	$"CanvasLayer/Death Popup".show()
	get_tree().paused = true
