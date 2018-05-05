

dialogue_negotiare_for_name = Dialogue:new{}
Gus.compteur = 0
Gus.compteurr =0

function state_Gus5()
  Gus.compteur = Gus.compteur+1
  print(Gus.compteurr)
  local sentence = DIALOGUE_GUS_COAX[Gus.compteur]
  local sentence1 = DIALOGUE_GUS_AMAD[Gus.compteur]
  local sentence2 = DIALOGUE_GUS_SUP[Gus.compteur]
  local sentence3 = DIALOGUE_GUS_AGG[Gus.compteur]
  
	if Gus.sociability > 89 then 
	-- Send this sentence to the status_board dialogue section, along with the speaker's name
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	-- Declare what will be the next state
		next_state = DIALOGUE_STATES_NEGOTIARE_FOR_NAME[2]
	
	elseif Gus.sociability < 89 and Gus.sociability > 50 then  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence1)
		next_state = DIALOGUE_STATES_NEGOTIARE_FOR_NAME[2]	
	
	elseif Gus.sociability < 50 and Gus.sociability > 20 then  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence2)
		next_state = DIALOGUE_STATES_NEGOTIARE_FOR_NAME[2]
		
	elseif Gus.sociability < 20 then  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence3)
		next_state = DIALOGUE_STATES_NEGOTIARE_FOR_NAME[2]
	end
	-- Return two element (that'll be used by the dialogue manager) :
	-- that the dialogue shall continue (DIALOGUE_NEXT)
	-- and that the next state to run will be next_state
	

	return DIALOGUE_NEXT, next_state
	end





function state_NPC5()
	local npc = Dialogue_manager.current_dialogue.interlocutor
	--local sentence1 = DIALOGUE_NPC_MY_NAME_IS:format(npc.label)
	--local sentence2 = DIALOGUE_NPC_I_WONT_GIVE_MY_NAME
	local sentence1 = DIALOGUE_NPC[npc.profile]["Bonjour"]
	local sentence2 = DIALOGUE_NPC[npc.profile]["Nope"]
	Gus.compteurr = Gus.compteurr + 1
	print(Gus.compteurr)
	--status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence2)
	Gus.interaction.guessProfile(sentence2)
	if (Gus.compteurr<3)	then
		Gus.lowSociability()
		next_state = DIALOGUE_STATES_NEGOTIARE_FOR_NAME[1]
	else 
		next_state = DIALOGUE_STATES_NEGOTIARE_FOR_NAME[3]
		Gus.compteur1=0
		Gus.compteur2=0
	 
	 end
	 return DIALOGUE_NEXT, next_state
	 end
	

function state_Gus6()
	local npc = Dialogue_manager.current_dialogue.interlocutor
	local gus_name = Gus.label
	local _, NPC_name = Gus.memory.retrieveInfo(Gus.memory.npcs[npc.label], "name")
	local sentence = DIALOGUE_GUS_COAX[4]:format(NPC_name, gus_name)
	status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	Gus.compteur=0
	Gus.compteurr=0
	return DIALOGUE_STOP
end

DIALOGUE_STATES_NEGOTIARE_FOR_NAME = {}

DIALOGUE_STATES_NEGOTIARE_FOR_NAME[1] = {state_Gus5, Gus.label}
DIALOGUE_STATES_NEGOTIARE_FOR_NAME[2] = {state_NPC5, NPC_LABEL}
DIALOGUE_STATES_NEGOTIARE_FOR_NAME[3] = {state_Gus6, Gus.label}

dialogue_negotiare_for_name:setInitState(DIALOGUE_STATES_NEGOTIARE_FOR_NAME[1])