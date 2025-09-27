extends Node2D


func _on_dialog_box_dialog_started() -> void:
	$Player.can_move = false

func _on_dialog_box_dialog_finished() -> void:
	$Player.can_move = true

func _on_laptop_menu_opened() -> void:
	$Player.can_move = false

func _on_laptop_menu_closed() -> void:
	$Player.can_move = true
