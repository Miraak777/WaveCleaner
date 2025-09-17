extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_new_run_button_pressed() -> void:
	var level: Node2D = load("res://levels/base_level.tscn").instantiate()
	get_tree().root.add_child(level)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = level
	
	var player: Player = load("res://player/player.tscn").instantiate()
	level.add_child(player)
	player.add_skill(load("res://skills/shoot.tscn"), 0)
	
	var game_master: GameMaster = load("res://game master/game_master.tscn").instantiate()
	game_master.player = player
	game_master.stages.append(load("res://game master/Stages/Stage 1.tres"))
	level.add_child(game_master)
	
	
	queue_free()
	
