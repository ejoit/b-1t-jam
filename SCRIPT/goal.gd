extends Node2D
@export var next_level = ""
@export var doortag : String

@export var keyneed: String = ""

var player

@onready var spawn: Marker2D = $Spawn



@onready var inv: Inv = preload("res://inventory/playerkeys.tres")

func _ready() -> void:
	
	
	add_to_group("doors")
	process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.timeline_ended.connect(end_chat)

func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.needkey = keyneed.to_upper()
	
	if body.is_in_group("player"):
		player = body
		Global.doorgoto = doortag
		
		if inv.has_key(keyneed):
			print("Door opened")

			get_tree().call_deferred("change_scene_to_file", next_level)
		else:
			player.chatting = true
			get_tree().paused = true
			print("Need key: " + keyneed)
			Dialogic.start("res://chats/no key.dtl")

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass



func end_chat():
	if not is_inside_tree():
		return
	get_tree().paused = false
	if player != null:
		player.chatting = false
  # disconnect when chat ends
