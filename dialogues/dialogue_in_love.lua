-- Automate pour lancer le dialogue ou Gus a réussi a séduire Britney

dialogue_in_love = Dialogue:new{}


function state_Gus1()
 
  local sentence = DIALOGUE_GUS_ASKING_INTEREST
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	-- Declare what will be the next state
		next_state = DIALOGUE_STATES_IN_LOVE[2]
	return DIALOGUE_NEXT, next_state
	end
	
	
function state_NPC()
	local npc = Dialogue_manager.current_dialogue.interlocutor
	local sentence = DIALOGUE_NPC_CHARMER_LOVE
	status_board.dialogue.addDialogue(npc.label, sentence)
	Gus.memory.addInfo("NPCs", {npc.label, "name", npc.label})
	
		next_state = DIALOGUE_STATES_IN_LOVE[3]
	 
	 
	 return DIALOGUE_NEXT, next_state
	 end
	
	
	function state_Gus2()
 
	local npc = Dialogue_manager.current_dialogue.interlocutor
	local gus_name = Gus.label
	local _, NPC_name = Gus.memory.retrieveInfo(Gus.memory.npcs[npc.label], "name")
	local sentence = DIALOGUE_GUS_HAPPY:format(NPC_name, gus_name)
	status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)

	-- Return only one element :
	-- that's the end of the dialogue (DIALOGUE_STOP)
	return DIALOGUE_STOP

	end
	
	
	
DIALOGUE_STATES_IN_LOVE= {}

DIALOGUE_STATES_IN_LOVE[1] = {state_Gus1, Gus.label}
DIALOGUE_STATES_IN_LOVE[2] = {state_NPC, NPC_label}
DIALOGUE_STATES_IN_LOVE[3] = {state_Gus2, Gus.label}

dialogue_in_love:setInitState(DIALOGUE_STATES_IN_LOVE[1])
	-- Return two element (that'll be used by the dialogue manager) :
	-- that the dialogue shall continue (DIALOGUE_NEXT)
	-- and that the next state to run will be next_state