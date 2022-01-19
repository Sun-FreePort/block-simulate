extends Node

export(PackedScene) var block

var onLeftClick: bool = false
var mapOriginPos: Vector2
var mouseOriginPos: Vector2

var blockList: Dictionary
var buildingList: Dictionary
var bodyList: Dictionary

func _ready():
	init_map()

func _process(delta):
	if onLeftClick:
		$Map.position = mapOriginPos + (get_viewport().get_mouse_position() - mouseOriginPos)

func _input(event):
	if event is InputEventMouseButton:
		onLeftClick = false
		
		if event.pressed == true && event.button_index == BUTTON_LEFT:
			onLeftClick = true
			mapOriginPos = $Map.position
			mouseOriginPos = get_viewport().get_mouse_position()

func init_map():
	var UNIT_WIDTH = 96
	var MAP_WIDTH = 12
	for y in range(1, MAP_WIDTH):
		for x in range(1, MAP_WIDTH):
			var blockObj = block.instance()
			$Map.add_child(blockObj)
			blockObj.name = "Block" + (x + ((y - 1) * MAP_WIDTH)) as String
			blockObj.position = Vector2(UNIT_WIDTH * x - UNIT_WIDTH / 2, UNIT_WIDTH * y - UNIT_WIDTH / 2)
			blockList["%d,%d".format([x, y])] = blockObj
			Signal.add(blockObj, "building_click", "_on_Block_mouse_exited")
