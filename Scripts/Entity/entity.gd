extends Node2D
class_name Entity

@onready var ground: TextureRect = $Ground
@onready var beastie_image: TextureRect = $BestieImage
@onready var hit_audio_stream_player: AudioStreamPlayer = $HitAudioStreamPlayer
@onready var died_audio_stream_player: AudioStreamPlayer = $DiedAudioStreamPlayer
@onready var died_animation_player: AnimationPlayer = $DiedAnimationPlayer
@onready var hit_animation_player: AnimationPlayer = $HitAnimationPlayer

signal died

signal hp_changed

var current_hp:int
var max_hp:int
var beastie_name:String

func create(_hp:int, beastie_image_path:String, _beastie_name:String):
	current_hp = _hp
	max_hp = _hp
	beastie_name = _beastie_name
	beastie_image.texture = load(beastie_image_path)
	died_animation_player.play_backwards("died")
	

func get_hit(dmg:int):
	hit_animation_player.play("hit")
	current_hp -=dmg
	hp_changed.emit()
	
	if current_hp <= 0:
		died_audio_stream_player.play()
		died_animation_player.play("died")
		await died_animation_player.animation_finished
		died.emit()
		return
		
	hit_audio_stream_player.play()
