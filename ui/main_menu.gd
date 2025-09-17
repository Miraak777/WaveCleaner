extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_new_run_button_pressed() -> void:
	get_tree().change_scene_to_file("res://World/World.tscn")
	
