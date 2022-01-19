extends Node

var building: Array = [0, 0, 0, 0, 0, 0, 0, 0]
var food: int = 45
var wood: int = 25
var sec: float
var hour: int
var day: int
var month: int
var HOUR_UNIT: float = 3.34

var bodyID: Dictionary

func _ready():
	init_save()

func init_save():
	bodyID = {
		"worker": 0,
		"attacker": 0,
		"defender": 0,
	}

func _process(delta):
	sec += delta
	if sec > HOUR_UNIT:
		one_hour()

func one_hour():
	sec = sec - HOUR_UNIT
	hour += 1
	Signal.emit("one_hour")
	if hour > 23:
		one_day()

func one_day():
	hour = 0
	day += 1
	Signal.emit("one_day")
	if day > 29:
		one_month()

func one_month():
	day = 1
	month += 1
	Signal.emit("one_month")
