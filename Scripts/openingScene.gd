extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Status.makeIndex:
		$VideoStreamPlayer.stop()
		$VideoStreamPlayer.stream = load("res://Textures/final.ogv")
		$VideoStreamPlayer.play()
		$Button.text = "restart"
		Status.makeIndex = 0
	var l = range(len($Label.text))
	for x in l:
		$Label.visible_characters = x
		$AudioStreamPlayer.play()
		await get_tree().create_timer(1.0/10).timeout
	$Button.show()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/LevelTypes/lvl1.tscn")
