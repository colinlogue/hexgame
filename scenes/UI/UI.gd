extends Container

signal player_finished_turn
signal player_new_turn
signal set_action(action_label)

func _on_Player_finished_turn():
	emit_signal("player_finished_turn")
	
func _on_Player_new_turn():
	emit_signal("player_new_turn")

func _on_button_pressed(label):
	emit_signal("set_action", label)