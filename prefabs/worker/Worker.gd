extends KinematicBody2D

var oID: int # 对象 ID
var workBID: int # 工作建筑 ID
var homeBID: int # 家建筑 ID
var hp: int
var isSleep: bool = false # 休息，后改为状态机
var status: String = "holding" # 状态机标识

func _ready():
	Signal.add(self, "one_hour", "_on_one_hour")

#func _process(delta):
func _on_one_hour(delta):
	match Save.hour:
		19:
			print("!")
			# 如果不在家，则往家走, goto_home()
		20, 21, 22, 23, 0, 1, 2, 3, 4, 5:
			print("!")
			# 如果不在家，则往家走, goto_home()
			# 如果在家，则进入休息状态, sleep()
		6:
			print("!")
			# 如果不在工场，则往工场走, goto_work()
		7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18:
			print("!")
			# 如果不在工场，则往工场走, goto_work()
			goto_work()
			# 如果已经在工场，则开始, working()
			

func print_save():
	return {
		"oID": oID,
		"workBID": workBID,
		"homeBID": homeBID,
		"hp": hp,
		"status": status,
		"positionX": position.x,
		"positionY": position.y,
	}

func load_save(workBID: int, homeBID: int, hp: int, status: String, positionX: int, positionY: int):
	self.workBID = workBID
	self.homeBID = homeBID
	self.hp = hp
	self.status = status
	position = Vector2(positionX, positionY)
	$Sprite.modulate = Color()

# 刷新工作地点
func refresh_work_local():
	pass

# 前往工作地点
func goto_work():
	pass

# 前往家中
func goto_home():
	pass

# 家中休息
func sleep():
	isSleep = true
	$Sprite.visible = false

# 工坊工作
func working():
#	触发工作计时器
	pass

# 原地等待
func holding():
	pass

# 有实体进入视野
func _on_Sign_body_entered(body):
	# 检测实体是生命体，是则检测实体是敌我，是敌人则计算迎击概率，不迎击就折返逃跑，逃跑则触发计时器，是队友则忽略
	pass
