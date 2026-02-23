extends Node3D

@onready var animation_player: AnimationPlayer = $human/AnimationPlayer

func play_animation(anim_name: String) -> void:
	if animation_player and animation_player.has_animation(anim_name):
		animation_player.play(anim_name)

func stop_animation() -> void:
	if animation_player:
		animation_player.stop()
