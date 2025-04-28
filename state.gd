extends Node
signal secret_learned(character)

var in_dialogue = false

func _process(delta: float) -> void:
	pass

func learn_secret(character):
	secret_learned.emit(character)

#Chain Locks
var chain_lock1 = false
var chain_lock2 = false
var chain_lock3 = false

#Game Wins
var game_won_ron = false
var game_won_elphie = false
var game_won_shawn = false

#Sean
var sean_convo_lock = 0
var sean_secret_known = false
var met_sean = false

#Rachel
var rachel_convo_lock = 0
var rachel_secret_known = false
var met_rachel = false

#Ben
var ben_convo_lock = 0
var ben_secret_known = false
var met_ben = false

#Julie
var julie_convo_lock = 0
var julie_secret_known = false
var met_julie = false

#Ron
var ron_convo_lock = 0
var ron_secret_known = false
var met_ron = false


######### Chain 2 ########

#Franklin
var franklin_convo_lock = 0
var franklin_secret_known = false
var met_franklin = false

	
#Eugene
var eugene_convo_lock = 0
var eugene_secret_known = false
var met_eugene = false

#Charles
var charles_convo_lock = 0
var charles_secret_known = false
var met_charles = false

#Bjorn
var bjorn_convo_lock = 0
var bjorn_secret_known = false
var met_bjorn = false

#Elphie
var elphie_convo_lock = 0
var elphie_secret_known = false
var met_elphie = false


######## Chain 3 ##########

#Clara
var clara_convo_lock = 0
var clara_secret_known = false
var met_clara = false

#Boo
var boo_convo_lock = 0
var boo_secret_known = false
var met_boo = false

#Spike
var spike_convo_lock = 0
var spike_secret_known = false
var met_spike = false

#Greg
var greg_convo_lock = 0
var greg_secret_known = false
var met_greg = false

#Shawn
var shawn_convo_lock = 0
var shawn_secret_known = false
var met_shawn = false

# Oogle
var met_oogle = false

# Jean
var met_jean = false
