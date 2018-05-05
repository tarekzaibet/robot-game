--------------------
-- Dialogue: Ask for name
--------------------

-- Each dialogue is represented as a finite state automaton.
-- In its current state, the dialogue is extremely simple:
-- Gus asks for the NPC name (state1), the NPC gives it (state2), Gus says "nice to meet you" (state3)

-- We create a new instance of Dialogue
dialogue_ask_for_name = Dialogue:new{}

function state_Gus1()
	local sentence = DIALOGUE_GUS_WHATS_YOUR_NAME
	
	-- Send this sentence to the status_board dialogue section, along with the speaker's name
	status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	
	-- Declare what will be the next state
	next_state = DIALOGUE_STATES_ASK_FOR_NAME[2]
	
	-- Return two element (that'll be used by the dialogue manager) :
	-- that the dialogue shall continue (DIALOGUE_NEXT)
	-- and that the next state to run will be next_state
	return DIALOGUE_NEXT, next_state
end


-- si Gus est trop fatigué ou trop asocial on sera dans cet état ou Gus ne va pas retenir le nom du PNJ 

function state_Gus3()
	local sentence = DIALOGUE_GUS_FU
	
	-- Send this sentence to the status_board dialogue section, along with the speaker's name
	status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	
	-- Declare what will be the next state
	
	
	-- Return two element (that'll be used by the dialogue manager) :
	-- that the dialogue shall continue (DIALOGUE_NEXT)
	-- and that the next state to run will be next_state
	return DIALOGUE_STOP
end



function state_NPC1()
	local npc = Dialogue_manager.current_dialogue.interlocutor
	
	local sentence1 = DIALOGUE_NPC[npc.profile]["Bonjour"]
	local sentence2 = DIALOGUE_NPC[npc.profile]["Nope"]
	if npc:isWillingToProvidePersonalData()then 
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence1)
		if Gus.vigor<50 then 
		Gus.interaction.guessProfile(sentence1)
		Gus.addSociability()
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[4]	
		
		elseif Gus.sociability<30 then
		Gus.interaction.guessProfile(sentence1)
		Gus.addSociability()
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[4]
			
		else
		Gus.memory.addInfo("NPCs", {npc.label, "name", npc.label})
		Gus.interaction.guessProfile(sentence1)
		Gus.addSociability()
		
		--Conditionelle pour remettre la vigueur de Gus a 100
		if npc.label == "Britney" then
		Gus.vigor=100
		end
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[3]
		end
	else  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence2)
		Gus.interaction.guessProfile(sentence2)
		Gus.lowSociability()
		--next_state = DIALOGUE_STATES_ASK_FOR_NAME[4]	
		next_state=DIALOGUE_STATES_ASK_FOR_NAME[5]
	 end
	 
	 return DIALOGUE_NEXT, next_state
	 end
	 
	
	




function state_Gus2()
	local npc = Dialogue_manager.current_dialogue.interlocutor
	local gus_name = Gus.label
	local _, NPC_name = Gus.memory.retrieveInfo(Gus.memory.npcs[npc.label], "name")
	local sentence = DIALOGUE_GUS_NICE_TO_MEET_YOU:format(NPC_name, gus_name)
	status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)

	-- Return only one element :
	-- that's the end of the dialogue (DIALOGUE_STOP)
	return DIALOGUE_STOP
end



Gus.compteurr =0

-- cet état détermine comment Gus va négocier, tout dépends de sa sociabilité
function state_Gus5()
  Gus.compteur = Gus.compteur+1
  if (Gus.compteur>4) then 
  Gus.compteur =1
  end
 
  local sentence = DIALOGUE_GUS_COAX[Gus.compteur]
  local sentence1 = DIALOGUE_GUS_AMAD[Gus.compteur]
  local sentence2 = DIALOGUE_GUS_SUP[Gus.compteur]
  local sentence3 = DIALOGUE_GUS_AGG[Gus.compteur]
  
  
  --ici la phrase que Gus va dire, dépends de la valeur de sa sociabilité, Gus ne négocie pas de façon binaire 

	if Gus.sociability >= 85 then 
	-- Send this sentence to the status_board dialogue section, along with the speaker's name
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence)
	-- Declare what will be the next state
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[6]
	
	elseif Gus.sociability < 85 and Gus.sociability >= 55 then  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence1)
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[6]	
	
	elseif Gus.sociability < 55 and Gus.sociability >= 25 then  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence2)
		print(sentence2)
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[6]
		
	elseif Gus.sociability < 25 then  
		status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence3)
		print(sentence3)
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[6]
	end
	-- Return two element (that'll be used by the dialogue manager) :
	-- that the dialogue shall continue (DIALOGUE_NEXT)
	-- and that the next state to run will be next_state
	

	return DIALOGUE_NEXT, next_state
	end
	
function state_NPC9()

  local npc = Dialogue_manager.current_dialogue.interlocutor
  
  local sentence1 = DIALOGUE_NPC[npc.profile]["Bonjour"]
  local sentence2 = DIALOGUE_NPC[npc.profile]["Nope"]
  local sentence3 =	DIALOGUE_NPC[npc.profile]["Corrupt"]
  
  
 -- si le PNJ peut etre corrompu et Gus propose de l'argent, le PNJ lui dis son nom 
  if npc:canBeCorrupted()==true then 
	    local n=npc.label
		status_board.dialogue.addDialogue(n, sentence3)
		Gus.money=Gus.money-20
		status_board.dialogue.addDialogue(n, sentence1)
		Gus.memory.addInfo("NPCs", {npc.label, "name", npc.label})
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[3]
  else
		local n=npc.label
		status_board.dialogue.addDialogue(npc.label, sentence3)
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[7]
	end

	return DIALOGUE_NEXT, next_state
	end


-- dans cet état Gus demande si le PNJ veut de l'argent 
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
	
	--status_board.dialogue.addDialogue(Dialogue_manager.current_state.speaker, sentence2)
	Gus.interaction.guessProfile(sentence2)
	if (Gus.compteurr<3)	then
		Gus.lowSociability()
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[5]
	elseif Gus.compteurr>=3 and Gus.money>20 then 
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[8]
	else
		next_state = DIALOGUE_STATES_ASK_FOR_NAME[7]
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

-- We list all the states
DIALOGUE_STATES_ASK_FOR_NAME = {}
-- I use numerical indexes here, but you can also use string values, up to you!
-- The table contains: the function that'll be called when we run this state and the speaker
DIALOGUE_STATES_ASK_FOR_NAME[1] = {state_Gus1, Gus.label}
DIALOGUE_STATES_ASK_FOR_NAME[2] = {state_NPC1, NPC_LABEL}
DIALOGUE_STATES_ASK_FOR_NAME[3] = {state_Gus2, Gus.label}
DIALOGUE_STATES_ASK_FOR_NAME[4] = {state_Gus3, Gus.label}
DIALOGUE_STATES_ASK_FOR_NAME[5] = {state_Gus5, Gus.label}
DIALOGUE_STATES_ASK_FOR_NAME[6] = {state_NPC5, NPC_LABEL}
DIALOGUE_STATES_ASK_FOR_NAME[7] = {state_Gus6, Gus.label}
DIALOGUE_STATES_ASK_FOR_NAME[8] = {state_Gus8, Gus.label}
DIALOGUE_STATES_ASK_FOR_NAME[9] = {state_NPC9, NPC_label}


-- We tell what's the dialogue's initial state (i.e. in which state does the dialogue have to start)
dialogue_ask_for_name:setInitState(DIALOGUE_STATES_ASK_FOR_NAME[1])