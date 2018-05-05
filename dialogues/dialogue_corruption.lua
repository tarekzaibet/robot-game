function state_Gus8()
	local sentence = DIALOGUE_GUS_CORRUPT
	
	-- Send this sentence to the status_board dialogue section, along with the speaker's name
	status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	
	-- Declare what will be the next state
	next_state = DIALOGUE_STATES_ASK_FOR_NAME[9]
	
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
	--local sentence3= DIALOGUE_NPC[npc.profile]["Corrupt"]
	--status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence3)

	
	
	Gus.compteurr = Gus.compteurr + 1
	print(Gus.compteurr)
	--status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence2)
	Gus.interaction.guessProfile(sentence2)
	if (Gus.compteurr<3)	then
		Gus.lowSociability()
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[5]
	elseif Gus.compteurr==3 then 
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[8]
	else
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[7]
		Gus.compteur1=0
		Gus.compteur2=0
	 
	 end
	 return DIALOGUE_NEXT, next_state
	 end
	