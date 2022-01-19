extends Node

signal building_click
signal building_choice
signal one_hour
signal one_day
signal one_month
signal resource_change

func _ready():
	pass

#func _process(delta):
#	pass

func emit(signalName: String, params: Array = []):
	params.push_front(signalName)
	callv("emit_signal", params)

func add(node, signalName, callback):
	connect(signalName, node, callback)
