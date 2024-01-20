extends CanvasLayer

@onready var fuel_bar = $FuelBar
@onready var score = $Score

func update_score(value):
	score.text = str(value)

func update_fuel(value):
	fuel_bar.value = value
