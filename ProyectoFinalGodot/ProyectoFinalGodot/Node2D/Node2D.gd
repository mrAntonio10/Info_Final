extends KinematicBody2D

var pixeles_x_metro : float =24
var velocidad :Vector2
var direccion :Vector2
var rapidez : float = 5 *pixeles_x_metro
onready var state_machine = $AnimationTree.get("parameters/playback")
var health = 10

func _ready():
	pass # Replace with function body.
	  
func _input(event):
	if Input.is_action_just_pressed("damage"):
		health -= 1
		print("health: ", health)
	cambiar_direccion()
	
func _physics_process(delta):	
	
	
	if Input.is_action_pressed("attack"):
		state_machine.travel("hero_attack")
		
	if Input.is_action_pressed("Specialattack"):
		state_machine.travel("hero_special_attack")
		
			
		
		
		#morir
	if health <= 0:
		state_machine.travel("hero_dead")
		direccion.x=0
		direccion.y=0
		
	
	
	movimiento()
	
func cambiar_direccion():
	direccion=Vector2.ZERO
	
	if Input.is_action_pressed("derecha"):
		direccion.x += 1
		state_machine.travel("hero_move")
		$Sprite.scale.x = abs($Sprite.scale.x)
	elif Input.is_action_pressed("izquierda"):
		direccion.x += -1
		state_machine.travel("hero_move")
		$Sprite.scale.x = abs($Sprite.scale.x) * -1
	elif Input.is_action_pressed("arriba"):
		direccion.y += -1
		state_machine.travel("hero_move")
	elif Input.is_action_pressed("abajo"):
		direccion.y += 1
		state_machine.travel("hero_move")
	else:
		state_machine.travel("hero_idle")
	
	direccion = direccion.normalized()
	

func movimiento():	
	if health >0:
		velocidad.x = direccion.x *rapidez
		velocidad.y = direccion.y *rapidez
		velocidad= move_and_slide(velocidad)
	
	
	
