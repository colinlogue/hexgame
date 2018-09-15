extends Node

signal finished_turn
signal new_turn
signal player_alert(code, message)

export (Color) var seed_color
export (Color) var claim_color

enum actions {NO_ACTION = 0, SEED_ACTION, CLAIM_ACTION, GROW_ACTION, HARVEST_ACTION}
enum alert_codes {CODE_END_TURN_ALERT}

var active = false
var action = NO_ACTION

func begin_turn():
	active = true
	emit_signal("new_turn")
	
func end_turn():
	if not action:
		var message = "Must select action before ending turn"
		emit_signal("player_alert", CODE_END_TURN_ALERT, message)
	else:
		active = false
		emit_signal("finished_turn")
	
func _on_hex_selection(hex):
	pass

func _on_Controls_set_action(action_label):
	print(action_label)