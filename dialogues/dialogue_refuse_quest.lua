-- automate pour le dialgoue ou Gus refuse la quete du PNJ

dialogue_refuse_quest = Dialogue:new{}


function state_Gus1()
 
  local sentence = DIALOGUE_GUS_REFUS
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	-- Declare what will be the next state
		next_state = DIALOGUE_STATES_REFUSE_QUEST[3]
	return DIALOGUE_NEXT, next_state
	end
	
	
function state_NPC()
	local npc = Dialogue_manager.current_dialogue.interlocutor
    local sentence = npc.quest.prompt
	status_board.dialogue.addDialogue(npc.label, sentence)
		next_state = DIALOGUE_STATES_REFUSE_QUEST[1]
	 
	 
	 return DIALOGUE_NEXT, next_state
	 end
	
	
	function state_Gus2()
 
  local sentence = DIALOGUE_GUS_BYE
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	-- Declare what will be the next state
	return DIALOGUE_STOP
	end
	
	
	
DIALOGUE_STATES_REFUSE_QUEST= {}

DIALOGUE_STATES_REFUSE_QUEST[1] = {state_Gus1, Gus.label}
DIALOGUE_STATES_REFUSE_QUEST[2] = {state_NPC, NPC_label}
DIALOGUE_STATES_REFUSE_QUEST[3] = {state_Gus2, Gus.label}

dialogue_refuse_quest:setInitState(DIALOGUE_STATES_REFUSE_QUEST[2])
	-- Return two element (that'll be used by the dialogue manager) :
	-- that the dialogue shall continue (DIALOGUE_NEXT)
	-- and that the next state to run will be next_state
	

	