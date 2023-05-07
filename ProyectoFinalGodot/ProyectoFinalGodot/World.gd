extends Node2D

const Player = preload("res://Node2D/Node2D.tscn")
const Enemy = preload("res://Enemy2/enemy2_2D.tscn")
const Enemy2 = preload("res://Enemy1/enemy2D.tscn")
const Exit = preload("res://ExitDoor.tscn")

var borders = Rect2(1, 1, 38, 21)

onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(200)
	
	var player = Player.instance()
	add_child(player)
	player.position = map.front()*32
	
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = map.front()*33
	
	var enemy2 = Enemy.instance()
	add_child(enemy2)
	enemy2.position = map.front()*24
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	exit.connect("leaving_level", self, "reload_level")
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
