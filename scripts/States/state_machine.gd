extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	# verificar todos os states
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			#faz a conexao entre o state e a função de transição
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	# Os estados tem que ser os mesmos para ocorrer a transicao
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
	
