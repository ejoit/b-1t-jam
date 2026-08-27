extends Control

var DisplayValue 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	DisplayValue = Global.global_energy
	$Label.text = str(Global.global_energy)
	

	
	if Global.sleeping == false:
		$Label2.text = str("AWAKE")
	elif Global.sleeping == true:
		$Label2.text = str("ASLEEP")

	$ProgressBar.max_value = Global.maxE
	$ProgressBar.value = DisplayValue
	$Label.text = "Warnings: %s" % Global.warnings
