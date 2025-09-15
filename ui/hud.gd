extends Control

var marker_list: Array[Marker2D] 
var health_list: Array[TextureProgressBar]

func _ready() -> void:
	marker_list = [
	$SkillPanel/SkillMarker1,
	$SkillPanel/SkillMarker2,
	$SkillPanel/SkillMarker3,
	$SkillPanel/SkillMarker4,
	$SkillPanel/SkillMarker5,
	$SkillPanel/SkillMarker6
	]

func update_health(health_percent: float):
	$HealthBar.value = health_percent
