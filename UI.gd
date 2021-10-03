extends Control

var hearts 

onready var HealthText = $HeartTexture/HealthText
onready var HealthImage = $HeartTexture

func set_hearts(value):
	hearts = clamp(value, 0, 10)
	HealthText.clear()
	HealthText.add_text(String(hearts))
	HealthImage.value = float(hearts)/10 * 100 
	
	
func draw_accessories():
	for i in range(Inventory.active_accessories.size()):
		var accTexture = TextureRect.new()
		accTexture.texture = load("res://Items/" + Inventory.active_accessories[i] + ".png")
		if i > 2:
			accTexture.expand = true
			accTexture.stretch_mode = 4
			accTexture.rect_scale = Vector2(0.5,0.5)
			accTexture.rect_position.x = 107 + (i-2)*9
			accTexture.rect_position.y = 15
		else:
			accTexture.rect_position.x = 64 + i*16
			accTexture.rect_position.y = 6
		add_child(accTexture)
func draw_consumables():
	if Inventory.current_consumable != null:
		$ConsSlot.texture = load("res://Items/" + Inventory.current_consumable + ".png")
	else:
		$ConsSlot.texture = null
		
func draw_weapon():
	if Inventory.current_weapon != null:
		$WeaponSlot.texture = load("res://Items/" + Inventory.current_weapon + ".png")
	else:
		$WeaponSlot.texture = null
		
func change_quantity(value, type):
	if value == null:
		get_node(type).text = ""
	else:
		get_node(type).text = String(value)
		

func _ready():
	self.hearts = Inventory.health
	HealthText.rect_clip_content = false
	Inventory.connect("health_changed", self, "set_hearts")
	Inventory.connect("weapon_changed", self, "draw_weapon")
	Inventory.connect("accessory_changed", self, "draw_accessories")
	Inventory.connect("consumables_changed", self, "draw_consumables")
	Inventory.connect("quantity_changed", self, "change_quantity")
	set_hearts(Inventory.health)
	draw_accessories()
	draw_consumables()
	draw_weapon()
	
		
	
func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		if (get_tree().paused):
			get_tree().paused = false
		else:
			get_tree().paused = true
		
	
