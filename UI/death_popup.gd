extends Panel

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(consts.path_to_main_menu)
