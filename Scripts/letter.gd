extends RigidBody3D

@export var letter = ""
@onready var defOutScale = $Shape/Outline.scale

func _ready() -> void:
	$Shape.mesh.text = letter
	$Shape/Outline.mesh.text = letter
	pass

func changeType(type, color=Color.DARK_RED):
	match type:
		"focus":
			$Shape/Outline.scale *= defOutScale*1.2
			$Shape.mesh.material.albedo = Color(0.617, 0.617, 0.617, 1.0)
		"attention":
			print(type)
		"wrong":	
			print(type)
		"default":
			$Shape/Outline.scale = defOutScale
			$Shape.mesh.material.albedo = Color.WHITE
			
			

func _process(delta: float) -> void:
	pass
