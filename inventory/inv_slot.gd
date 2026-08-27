extends Panel
var stored_item: InvItem
@onready var item_vis: Sprite2D = $ColorRect/Sprite2D
@onready var item_name: Label = $ColorRect/ItemName
var itemtosend 
signal energy_item

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP


func _on_button_pressed() -> void:
	print("works")

func _gui_input(event):
	print("ye")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var player = get_tree().get_first_node_in_group("player")
				
				if player is CharacterBody2D:
					player.use_item(itemtosend)
				else:
					print("player")
				
			
func update(item: InvItem):
	itemtosend = item

	if not item:
		item_vis.visible = false
		item_name.text = ""
	else:
		item_vis.visible = true
		item_vis.texture = item.texture
		item_name.text = item.name
