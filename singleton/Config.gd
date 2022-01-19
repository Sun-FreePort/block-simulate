extends Node

var buildingChoiceID: int = -1
var buildingsShow: bool = false
var buildings: Array
var armies: Array
var country: Array
var credit: Array = [
	"建筑、按钮素材源自 YeoSowon（yeosowon.zcool.com.cn）",
	"部分图标源自 Icons8（igoutu.cn）",
]

func _ready():
	init_building()
	init_army()
	init_country()

#func _process(delta):
#	pass

func init_country():
	country = [{
		"0:color": "#"
	}]

func init_army():
	armies = [{
		"id": 0,
		"name": "农民",
		"detail": "描述：老实巴交的农夫，除了农活，也乐意干其他任何工作。\n- 伤害：3~9\n- 移动：7\n- 间隔：1.2s\n- 生命：35\n- 恢复：0.2/s",
		"morale": 40,
		"attack_min": 3,
		"attack_max": 9,
		"move": 7,
		"attack_cd": 1.2,
		"hp_max": 35,
		"hp_recover": 0.2,
		"hp_recover_local": 0.2,
	}, {
		"id": 1,
		"name": "卫兵",
		"icon": "_defence",
		"detail": "描述：身着厚重木甲的卫士，虽无铁甲傍身，但他们守护家园的意志力和良好的训练，使得技艺较为高超。\n- 伤害：12~16\n- 移动：6\n- 攻击间隔：1s\n- 生命：65\n- 恢复：0.2/s（本土加倍）",
		"morale": 100,
		"attack_min": 12,
		"attack_max": 16,
		"move": 6,
		"attack_cd": 1,
		"hp_max": 65,
		"hp_recover": 0.2,
		"hp_recover_local": 0.4,
	}, {
		"id": 2,
		"name": "征召兵",
		"icon": "_attacker",
		"detail": "描述：一些经过短期训练的农夫，木甲穿着在身，却有沉重的意味。\n- 伤害：8~12\n- 移动：5\n- 攻击间隔：1s\n- 生命：45\n- 恢复：0.2/s",
		"morale": 80,
		"attack_min": 8,
		"attack_max": 12,
		"move": 5,
		"attack_cd": 1,
		"hp_max": 45,
		"hp_recover": 0.2,
		"hp_recover_local": 0.2,
	}]
	
func init_building():
	buildings = [{
		"id": 0,
		"type": 1,
		"name": "农舍",
		"icon": "res://images/buildings/building0-1",
		"detail": "增加 2 农民，需要 5 木材。\n- 民生建筑\n- 耐久：80\n- 农民在周边 3 单位距离内工作\n- 农民会在傍晚开始回家，清晨前去工作\n- 每次升级农民 + 1，所需材料 + 40%",
		"include": 2, # 包含，床位或岗位
	}, {
		"id": 1,
		"type": 2,
		"name": "农田",
		"icon": "res://images/buildings/building1-1",
		"detail": "增加 5 食物收入，需要 5 木材，需要 1 农民来工作。\n- 生产建筑\n- 耐久：144\n- 每次升级食物 + 1，所需材料 + 40%",
		"include": 1,
	}, {
		"id": 2,
		"type": 2,
		"name": "伐木场",
		"icon": "res://images/buildings/building2-1",
		"detail": "增加 4 木材收入，需要 1 农民来工作\n- 生产建筑\n- 耐久：260\n- 每次升级木材 + 1，所需材料 + 40%",
		"include": 1,
	}, {
		"id": 3,
		"type": 2,
		"name": "采石场",
		"icon": "res://images/buildings/building3-1",
		"detail": "增加 2 石料收入，需要 12 木材，需要 1 农民来工作\n- 生产建筑\n- 耐久：460\n- 每次升级石料 + 1，所需材料 + 50%",
		"include": 1,
	}, {
		"id": 4,
		"type": 3,
		"name": "哨所",
		"icon": "res://images/buildings/building4-1",
		"detail": "增加 2 卫兵，需要 8 木材 6 石料，消耗 3 食物\n- 军事建筑\n- 耐久：350\n- 卫兵在周边 4 单位距离内巡逻\n- 卫兵死亡后，在 15s 后恢复\n- 每次升级卫兵 + 1，所需材料 + 35%",
		"include": 2,
	}, {
		"id": 5,
		"type": 2,
		"name": "市集",
		"icon": "res://images/buildings/building3-1",
		"detail": "3 * 3 范围的居民食物消耗降低 0.1，每人每次消耗时，提供 0.2 钱币，需要 42 木材，需要 1 农民来工作\n- 经济建筑\n- 耐久：210\n- 每次升级提供 0.1 钱币，所需材料 +150%",
		"include": 1,
	}, {
		"id": 6,
		"type": 4,
		"name": "临时兵营",
		"icon": "res://images/buildings/building3-1",
		"detail": "增加 3 征召兵，需要 80 木材 26 石料 50 货币，消耗 6 食物\n- 军事建筑\n- 耐久：410\n- 征召兵将主动攻击接壤的敌人建筑和士兵\n- 没有敌人时，征召兵在周边 2 单位距离内巡逻\n- 征召兵死亡后，在 20s 后恢复\n- 每次升级征召兵 + 1，所需材料 + 50%",
		"include": 3,
	}]
