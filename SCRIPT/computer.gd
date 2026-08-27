extends StaticBody2D

@export var keyinventory: Inv
@export var item: InvItem
@export var chat = ""

var player_in_range = false
var player 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	Dialogic.timeline_ended.connect(end_chat)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("chat") and not player.chatting:
		start_chat()

func _on_chat_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player = body


func _on_chat_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_in_range = false
		
func start_chat():
	if player == null:
		return
	
	player.chatting = true
	get_tree().paused = true
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start(chat)

func _on_dialogic_signal(argument:String):
	if argument == "Give_Item":
		print(item)
		print("succses")
		if keyinventory.items.has(item):
			print("Already have it")
		else:
			keyinventory.items.append(item)
		
	
	
func end_chat():
	get_tree().paused = false
	if player != null:
		player.chatting = false
	if Dialogic.signal_event.is_connected(_on_dialogic_signal):
		Dialogic.signal_event.disconnect(_on_dialogic_signal)   # disconnect when chat ends
