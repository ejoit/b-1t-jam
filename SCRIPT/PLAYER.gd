extends CharacterBody2D


var sleep = false
@export var speed = 100
var coffee = 0

var sleepscore = 0
var moving = false
var key_array = []
var chatting = false
var in_inv = false
@onready var animatedsprite: AnimatedSprite2D = $AnimatedSprite2D
@export var max_energy = 15
@export var inv: Inv
@export var keyinv: Inv
signal inchat


func _ready() -> void:
	add_to_group("player")
	add_to_group("PLAYER")
	Global.maxE = max_energy
	Global.started = true


	animatedsprite.play("idle")
	print("test")
	sleep = false
	energy_use()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		if sleep == false:
			velocity = Vector2.ZERO
			sleep = true

		elif sleep == true and Global.global_energy >= 5:
			sleep = false


	
func _physics_process(delta):
	if sleep == false:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed
	elif sleep == true:
		velocity = Vector2.ZERO
		
	if velocity ==  Vector2.ZERO and sleep == false:
		animatedsprite.play("idle")
		
	elif velocity >=  Vector2.ZERO and sleep == false:
		animatedsprite.play("walk")
		$AnimatedSprite2D.flip_h = false
	elif velocity <=  Vector2.ZERO and sleep == false:
		animatedsprite.play("walk")
		$AnimatedSprite2D.flip_h = true
	elif sleep == true:
		animatedsprite.play("sleep")
	move_and_slide()

	
func _process(delta: float) -> void:
	Global.sleeping = sleep
	if Global.global_energy <= 0:
		sleep = true
	if Global.global_energy == max_energy:
		sleep = false
	
	if chatting == true:
		emit_signal("inchat")
	
	
	
	
func energy_use():
	while true:
			await get_tree().create_timer(1.0).timeout
			if chatting:
				continue
			if Global.in_inv:
				continue
			if sleep == true:

				Global.global_energy+= 2
			if sleep == false:
				
					Global.global_energy -= 1
			
			
			Global.global_energy = clamp(Global.global_energy, 0, max_energy)




func use_item(item: InvItem):
	print("Using ", item.name)
	match item.item_id:
		"coffee":
			Global.global_energy += 10
		"WO":
			Global.warnings = 0

	Global.global_energy = clamp(Global.global_energy, 0, max_energy)

	
	

	inv.items.erase(item)
