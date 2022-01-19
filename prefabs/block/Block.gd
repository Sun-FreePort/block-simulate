extends Area2D

export(PackedScene) var building
var building_has: bool

func _ready():
	pass

#func _process(delta):
#	pass

func print_save():
	return {
		"building_has": building_has,
	}

func load_save(building_has: bool):
	self.building_has = building_has

func _on_Block_mouse_entered():
	if Config.buildingsShow && !building_has:
		$Frame.show()

func _on_Block_mouse_exited():
	$Frame.hide()

func _on_Block_input_event(viewport, event, shape_idx):
	if Config.buildingChoiceID != -1 && !building_has:
		if (event is InputEventMouseButton && event.pressed):
			# TODO: check resource
			Signal.emit("resource_change")
			
			var obj = building.instance()
			add_child(obj)
			obj.load_save({
				"bID": Config.buildingChoiceID
			})
			Signal.emit("building_choice", [-1])
			building_has = true
