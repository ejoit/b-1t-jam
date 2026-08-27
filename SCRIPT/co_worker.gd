extends CharacterBody2D
var player_visible := false
var player = null
var was_visible = false
var warnings = 0
var warning_timer := 0.0
var current_action = 0
@export var max_instructions = 0




@export var intructions: Array[ActionResource]
var warning_in_progress = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


@onready var polygon: CollisionPolygon2D = $vision/CollisionPolygon2D

var ismoving = false

@onready var ray1: RayCast2D = $vision/RayCast1
@onready var ray2: RayCast2D = $vision/RayCast2
@onready var ray3: RayCast2D = $vision/RayCast3
@onready var ray4: RayCast2D = $vision/RayCast4
@onready var ray5: RayCast2D = $vision/RayCast5
@onready var ray6: RayCast2D = $vision/RayCast6
@onready var ray7: RayCast2D = $vision/RayCast7
@onready var ray8: RayCast2D = $vision/RayCast8
@onready var ray9: RayCast2D = $vision/RayCast9

@onready var line: Line2D = $vision/Line2D

var points: PackedVector2Array

var currentinstruction = 0


func _ready() -> void:
	animated_sprite.play("idle")
	points = polygon.polygon
	line.closed = true
	play_next_instruction()
	
	
	
func play_next_instruction():

	
	var instruction = intructions[currentinstruction]
	
	if intructions.size() == 0:
		return
	
	match instruction.action:
		
		"stay":
			if not is_inside_tree(): return
			await stay(instruction.StayStill)
		"move":
			if not is_inside_tree(): return
			await move(instruction.distance, instruction.direction, instruction.speed)
		"TurnView":
			if not is_inside_tree(): return
			await turn_view(instruction.ViewTurn)
	currentinstruction += 1
	currentinstruction %= intructions.size()

	play_next_instruction()
	
func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		print("I see player")
		player_visible = true
		player = body
		
func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		print("Player left")
		player_visible = false
	



func _physics_process(delta):
		update_vision()
		

		
		

	
func update_vision():
	

	# ray 1
	if ray1.is_colliding():
		points.set(1, polygon.to_local(ray1.get_collision_point()))
	else:
		points.set(1, ray1.target_position)

	# ray 2
	if ray2.is_colliding():
		points.set(2, polygon.to_local(ray2.get_collision_point()))
	else:
		points.set(2, ray2.target_position)
	#ray3
	if ray3.is_colliding():
		points.set(3, polygon.to_local(ray3.get_collision_point()))
	else:
		points.set(3, ray3.target_position)

	# ray 4
	if ray4.is_colliding():
		points.set(4, polygon.to_local(ray4.get_collision_point()))
	else:
		points.set(4, ray4.target_position)

	# Middle ray
	if ray5.is_colliding():
		points.set(5, polygon.to_local(ray5.get_collision_point()))
	else:
		points.set(5, ray5.target_position)
	# ray 6
	if ray6.is_colliding():
		points.set(6, polygon.to_local(ray6.get_collision_point()))
	else:
		points.set(6, ray6.target_position)

	# Bottom ray
	if ray7.is_colliding():
		points.set(7, polygon.to_local(ray7.get_collision_point()))
	else:
		points.set(7, ray7.target_position)

	# ray 1
	if ray8.is_colliding():
		points.set(8, polygon.to_local(ray8.get_collision_point()))
	else:
		points.set(8, ray8.target_position)

	if ray9.is_colliding():
		points.set(9, polygon.to_local(ray9.get_collision_point()))
	else:
		points.set(9, ray9.target_position)
		



	polygon.polygon = points
	line.points = points

func _process(delta):
	if ismoving == true:
		$AnimatedSprite2D.play("walk")
	elif ismoving == false:
		$AnimatedSprite2D.play("idle")
	
	if player_visible:
		print("plyaer in zone")
		
		
	
	if player_visible == true:
		if player.sleep == true:
			await iseeu()
	else:
		pass
		
	if Global.warnings == 3:
		get_tree().change_scene_to_file("res://SCENE/OVER.tscn")
		
func iseeu():
	if warning_in_progress == true:
		pass
	elif warning_in_progress == false:
		warning_in_progress = true
		Global.warnings += 1
		await get_tree().create_timer(1.0).timeout
		warning_in_progress = false
		
func move(distance, direction, speed):

	direction = direction.normalized()  
	var target_position = position + (direction * distance)
	$vision.rotation = direction.angle()

	
	if direction.x != 0:
		animated_sprite.flip_h = direction.x < 0
		
	if not is_inside_tree():return
	
	#if not is_inside_tree(): return

	await get_tree().create_timer(0.4).timeout
	if not is_inside_tree():
		return
	ismoving = true
	if not is_inside_tree():return



	
	while position.distance_to(target_position) > 0.1:
		if not is_inside_tree():return
		if get_tree().paused:
			await get_tree().process_frame
			continue
		
		animated_sprite.play("walk")
		position = position.move_toward(target_position, speed * get_process_delta_time())
		if not is_inside_tree(): return
		await get_tree().process_frame
	if not is_inside_tree():return
		
	position = target_position
	animated_sprite.play("idle")
	ismoving = false
	
	
func stay(StayStill):
	print("Staying for ", StayStill, " seconds")
	await get_tree().create_timer(StayStill).timeout
	
	
func turn_view(ViewTurn):

	$vision.rotation = ViewTurn.angle()
	if not is_inside_tree(): return
	await get_tree().create_timer(3.0).timeout
