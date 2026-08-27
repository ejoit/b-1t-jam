extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var key: Inv = preload("res://inventory/playerkeys.tres")

@onready var slots: Array = $TabContainer/ITEMS/VBoxContainer.get_children()
@onready var keyslots: Array = $TabContainer/KEYITEMS/VBoxContainer.get_children()
@onready var vbox = $TabContainer/ITEMS/VBoxContainer
@onready var keybox = $TabContainer/KEYITEMS/VBoxContainer
@export var inventory_slot_scene: PackedScene

@onready var item_list = $Panel/VBoxContainer
@export var player_items: Resource
@export var player_keys: Resource

var is_open = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	update_slots()
	load_items()
	close()


func load_items():
	for item in inv.items:
		var slot = inventory_slot_scene.instantiate()
		vbox.add_child(slot)
		slot.update(item)
	
	for item in key.items:
		var slot = inventory_slot_scene.instantiate()
		vbox.add_child(slot)
		slot.update(item)
	
		
	
func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
	
	for i in range(min(key.items.size(), keyslots.size())):
		keyslots[i].update(key.items[i])
		

func update_inventory():
	# remove old slots
	

	for child in vbox.get_children():
		child.queue_free()
		
	for child in keybox.get_children():
		child.queue_free()
		
	# add current items
	for item in inv.items:
		var slot = inventory_slot_scene.instantiate()
		vbox.add_child(slot)
		slot.update(item)
	
	for item in key.items:
		var keyslots = inventory_slot_scene.instantiate()
		keybox.add_child(keyslots)
		keyslots.update(item)
		
		
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("I"):
		if is_open:
			close()
		else:
			open()
	if is_open:
		update_inventory()
	
func open():
	Global.in_inv = true
	get_tree().paused = true
	visible = true
	is_open = true
	show_items()

func close():
	Global.in_inv = false
	get_tree().paused = false
	visible = false
	is_open = false
	
func show_items():
	pass
	
