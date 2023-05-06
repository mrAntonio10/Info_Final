extends KinematicBody2D

var pixeles_x_metro : float =24
var velocidad :Vector2
var direccion :Vector2
var rapidez : float = 5 *pixeles_x_metro
 
func _ready():
	pass # Replace with function body.
	  
func _input(event):
	cambiar_direccion()
	
func _physics_process(delta):	
	movimiento()
	
func cambiar_direccion():
	direccion=Vector2.ZERO
	
	if Input.is_action_pressed("derecha"):
		direccion.x += 1
	if Input.is_action_pressed("izquierda"):
		direccion.x += -1
	if Input.is_action_pressed("arriba"):
		direccion.y += -1
	if Input.is_action_pressed("abajo"):
		direccion.y += 1
		
	direccion = direccion.normalized()
	
	
func movimiento():	
	velocidad.x = direccion.x *rapidez
	velocidad.y = direccion.y *rapidez
	velocidad= move_and_slide(velocidad)
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
