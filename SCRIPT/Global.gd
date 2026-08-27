extends Node


var global_energy = 15
var g_sleepscore = 0

var sleeping = false
var doorgoto
var maxE = 0
var warnings: int
var started = false
const inv = preload("res://inventory/playerinv.tres")
const PLAYERKEYS = preload("res://inventory/playerkeys.tres")

var needkey = ""
var chestopened = false
var item2give
var in_inv = false
const PLAYERINV = preload("uid://cdfenwjcf7om6")
const keyinv = preload("res://inventory/playerkeys.tres")
func _process(delta: float) -> void:

	global_energy = clamp(global_energy, 0, maxE)

func _ready() -> void:
	global_energy = 15
	
func add_item(item):
	print("ADDING ITEM")
	print(item)
	inv.items.append(item)


func reset_game():
	global_energy = 10
	g_sleepscore = 0
	global_energy = 10
	sleeping = false
	doorgoto = ""
	needkey = ""
	warnings = 0
	Dialogic.VAR.Chestopened = false
	Dialogic.VAR.spoken = false
	Dialogic.VAR.spoken2guy2 = false
	Dialogic.VAR.ThomasSp = false
	Dialogic.VAR.bobchat = false


	# Clear inventory
	inv.items.clear()
	PLAYERKEYS.items.clear()


	# Clear key inventory

	# Clear chest data if you're storing it
