extends Control

var radius: float
@onready var radius_label: Label = $Radius/Label2

func _on_h_slider_value_changed(value: float) -> void:
	radius = value
	radius_label.text = str(value) + " m"
