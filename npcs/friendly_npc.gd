extends StaticBody2D
@onready var animatedsprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	animatedsprite.play("idle")
	process_mode = Node.PROCESS_MODE_ALWAYS

	Dialogic.timeline_ended.connect(end_chat)

# Called every frame. 'delta' is the elapsed time since the previous frame.

@export var keyinventory: Inv
@export var item: InvItem
@export var item2: InvItem
@export var chat = ""

var player_in_range = false
var player 
# Called when the node enters the scene tree for the first time.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("chat") and not player.chatting:
		start_chat()

func _on_chatarea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player = body


func _on_chatarea_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_in_range = false



func start_chat():
	if player == null:
		return
	
	player.chatting = true
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
			
	if argument == "Give_Item2":
		print(item2)
		print("succses")
		if keyinventory.items.has(item2):
			print("Already have it")
		else:
			keyinventory.items.append(item2)
			
	if argument == "END":
		get_tree().paused = false
		get_tree().call_deferred("change_scene_to_file", "res://SCENE/END.tscn")
		
	
	
func end_chat():

	if player != null:
		player.chatting = false


	if Dialogic.signal_event.is_connected(_on_dialogic_signal):
		Dialogic.signal_event.disconnect(_on_dialogic_signal)  



		
