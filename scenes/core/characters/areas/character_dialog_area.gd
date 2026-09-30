class_name CharacterDialogArea extends Area2D

@export var bt_player: BTPlayer
@export var interaction_position: Node2D
@export var text: String
@export var offset: Vector2
@export var stay: bool = false
@export var duration: float = 1.0
@export var color: Color = Color.WHITE

var ui_label: Label = Label.new()
var is_showing = false
var is_running_timeline = false

func _input(_event: InputEvent) -> void:
	if is_showing and Input.is_action_just_pressed("dialog"):
		if not is_running_timeline:
			is_running_timeline = true
			bt_player.blackboard.set_var("talking", true)
			Dialogic.start("npc")

func _ready() -> void:
	is_showing = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	
func _on_timeline_ended():
	is_running_timeline = false
	bt_player.blackboard.set_var("talking", false)

func _on_body_entered(body):
	if body:
		if interaction_position:
			if stay:
				float_text_stay()
				is_showing = true
			else:
				float_text()
				
func _on_body_exited(body):
	if body:
		if stay:
			fade_out_text()
			is_showing = false
			
func float_text():
	var pos = interaction_position.global_position + offset
	var label = Label.new()
	label.z_index = 1000
	label.text = text
	label.modulate = color
	label.position = pos
	label.material = CanvasItemMaterial.new()
	label.material.light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED
	label.add_theme_font_size_override("font_size", 16)
	var root = get_tree().get_root()
	root.add_child(label)
	var tween = create_tween()
	tween.parallel().tween_property(label, "position", label.position + Vector2(0, -16), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(label, "modulate:a", 0.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func(): label.queue_free())
	
func float_text_stay():
	var pos = interaction_position.global_position + offset
	ui_label.z_index = 1000
	ui_label.text = text
	ui_label.modulate = color
	ui_label.modulate.a = 0.0
	ui_label.position = pos
	ui_label.add_theme_font_size_override("font_size", 16)
	var root = get_tree().get_root()
	root.add_child(ui_label)
	var tween = create_tween()
	tween.parallel().tween_property(ui_label, "position", ui_label.position + Vector2(0, -16), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(ui_label, "modulate:a", 1.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func fade_out_text():
	var tween = create_tween()
	tween.parallel().tween_property(ui_label, "position", ui_label.position + Vector2(0, 16), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(ui_label, "modulate:a", 0.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
