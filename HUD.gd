extends Node

#export (PackedScene) var building_button
var time: float
var timePressTarget: int = -1
var timePress: float

func _ready():
	shadow_buttons()
	hide_all_panel()
	show_building_bar(true)
	_on_upgrade_ui()
	
	Signal.add(self, "one_hour", "_on_upgrade_ui")
	Signal.add(self, "resource_change", "_on_upgrade_ui")

func _process(delta):
	if timePressTarget != -1:
		if timePress > 0.6:
			show_detail_building(timePressTarget)
			timePressTarget = -1
		else:
			timePress += delta

func shadow_buttons():
	for item in Config.buildings:
		var button = TextureButton.new()
		$BuildingList/List.add_child(button)
		button.name = "Button" + str(item["id"])
		button.texture_normal = load(item["icon"] + ".png")
		button.texture_pressed = load(item["icon"] + "_press.png")
		button.connect("button_up", self, "_on_building_button_up")
		button.connect("button_down", self, "_on_building_button_down", [item["id"]])

func show_building_bar(force = false):
	if $BuildingList.visible || force:
		$BuildingList.hide()
		Config.buildingsShow = false
		Signal.emit("building_click")
	else:
		$BuildingList.show()
		Config.buildingsShow = true

func hide_all_panel():
	$DetailPanel.hide()

func show_detail_building(id: int):
	timePressTarget = -1
	timePress = 0
	if Config.buildings.size() >= id:
		$DetailPanel/Title.text = Config.buildings[id].name
		$DetailPanel/Product.text = Config.buildings[id].detail
	else:
		$DetailPanel/Title.text = "建筑不存在"
		$DetailPanel/Product.text = "建筑不存在"
	$DetailPanel.show()

func _on_building_button_up():
	if timePress < 0.6 && timePressTarget != -1:
		Signal.emit("building_choice", [timePressTarget])
	timePressTarget = -1
	timePress = 0

func _on_building_button_down(id: int):
	timePressTarget = id
	timePress = 0
	
func _on_upgrade_ui():
	$Resource/Date/Label.text = "{month}月{day}日{hour}点".format({
		"month": Save.month,
		"day": "%2d" % Save.day,
		"hour": "%2d" % Save.hour,
	})
	$Resource/Food/Label.text = str(Save.food)
	$Resource/Wood/Label.text = str(Save.wood)
