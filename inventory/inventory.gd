extends Resource

class_name Inv

@export var items: Array[InvItem]

func has_key(key_id: String) -> bool:
	for item in items:
		if item.item_id == key_id:
			return true
	return false

func add_item(item: InvItem):
	items.append(item)
