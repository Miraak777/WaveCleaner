extends Control

var marker_list: Array[Marker2D] 

func _ready() -> void:
	marker_list = [
	$Panel/SkillMarker1,
	$Panel/SkillMarker2,
	$Panel/SkillMarker3,
	$Panel/SkillMarker4,
	$Panel/SkillMarker5,
	$Panel/SkillMarker6
]
