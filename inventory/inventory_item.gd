extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var item_id: String = ""
@export var is_key: bool = false
@export var energy: int



func use():
	match item_id:
		"coffee":
			Global.g_energy += 20
			print("Drank coffee!")
		"WO":
			Global.warnings = 0
