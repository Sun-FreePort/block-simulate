extends TextureRect

var time: float = -1

func _ready():
	Signal.add(self, "building_choice", "_on_building_choice")

func _process(delta):
	if time != -1:
		time += delta
		if time > 0.05:
			time = 0
			rect_position = get_global_mouse_position() + Vector2(1, 1)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed == true && event.button_index == BUTTON_RIGHT:
			time = -1
			texture = null
			rect_position = Vector2(-100, -100)
			Config.buildingChoiceID = -1

func _on_building_choice(id: int):
	if id == -1:
		time = -1
		Config.buildingChoiceID = -1
		texture = null
	else:
		time = 0
		Config.buildingChoiceID = id
		texture = load(Config.buildings[id].icon + ".png")
