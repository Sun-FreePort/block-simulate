extends Area2D

export(PackedScene) var workerPrefab
export(PackedScene) var attackerPrefab
export(PackedScene) var defenderPrefab

var oID: int # 本栋建筑 ID
var buildingID: int # 建筑类型 ID
var bodyID: Array # 关联生命 ID
var country: int # 国家 ID
var time: float

func _ready():
	refresh_building()

func _process(delta):
	time += delta
	if time > 1:
		time = time - 1
		upgrade_day()

func print_save():
	return {
		"oID": oID,
		"bID": buildingID,
		"bodyID": bodyID,
		"country": country,
		"time": time,
	}

func load_save(data: Dictionary):
	buildingID = data["bID"]
	refresh_building()

func refresh_building():
	if buildingID != -1:
		$Icon.texture = load(Config.buildings[Config.buildingChoiceID].icon + ".png")
	else:
		$Icon.texture = null

func upgrade_day():
	if Config.buildings[buildingID].type == 1:
		# 住宅：检测空床位数量，如果空，则检测能否衍生，如果能，则生成生命体实例，且 bodyID 增加
		if bodyID.size() < Config.buildings[buildingID].include:
			var work = workerPrefab.instance()
			get_parent().add_child(work)
			Save.bodyID["worker"] += 1
			bodyID.append(Save.bodyID["worker"])
	elif Config.buildings[buildingID].type == 2:
		# 工场：检测空岗位数量，如果空，则检测能否招募，如果能，则关联生命体实例，且 bodyID 增加
		pass
	elif Config.buildings[buildingID].type == 3:
		# 卫戍部队
		pass
	elif Config.buildings[buildingID].type == 4:
		# 野战部队
		pass
	else:
		print("Error: Building has undefined type.")
