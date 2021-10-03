extends Node

var faceRight = true
var isAttacking = false
signal weapon_changed
signal accessory_changed
signal consumables_changed
signal quantity_changed (value, type)

var active_weapons = [ "Dagger", "TortureSword", "FishingRod", "IceSword"]
var active_accessories = ["Boots", "Boots", "Boots", "Boots", "Boots", "Boots"]
var active_consumables = ["Bomb", "IceStorm", "GoldenKey"]
var current_consumable = active_consumables[0]
var current_weapon = active_weapons[0]
var i = 0
var j = 0

func _ready():
	connect("accessory_changed", self, "instance_accessory")
	self.health = 5
	
func _input(_event):
	if Input.is_action_just_pressed("consumables_change"):
		Utils.player.get_node(current_consumable).queue_free()
		j+=1
		if j >= active_consumables.size():
			j = 0
		current_consumable = active_consumables[j]
		var acc = load("res://Items/"+current_consumable+".tscn")
		var instance = acc.instance()
		Utils.player.add_child(instance)
		emit_signal("consumables_changed")
		emit_signal("quantity_changed", instance.count, "ConsumablesText")
		
	if Input.is_action_just_pressed("weapon_change"):
		Utils.player.weapon.queue_free()
		i+=1 
		if i >= active_weapons.size():
			i = 0
		current_weapon = active_weapons[i]
		var weapon = load("res://Items/" + current_weapon + ".tscn")
		var instance = weapon.instance()
		Utils.player.add_child(instance)
		Utils.player.weapon = instance
		Utils.player.weapon.set_static_pos()
		emit_signal("weapon_changed")
		emit_signal("quantity_changed", instance.count, "WeaponText")

func instance_accessory():
	var acc = load("res://Items/"+active_accessories[-1]+".tscn")
	var instance = acc.instance()
	Utils.player.add_child(instance)
	
func delete_consumable():
	active_consumables.erase(current_consumable)
	if active_consumables.size() > 0:
		j-=1
		current_consumable = active_consumables[j]
		var acc = load("res://Items/"+current_consumable+".tscn")
		var instance = acc.instance()
		Utils.player.add_child(instance)
	else:
		current_consumable = null
	emit_signal("consumables_changed")
	

var health = 5 setget set_health

signal no_health(boolean)
signal health_changed(value)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health", true)

	

