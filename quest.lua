----------------------------------
-- Quests
----------------------------------

----------------------------------
-- Quest class
----------------------------------

Quest = {
	prompt = "";	-- the dialogue line that says what is expected of Gus
	resolved = false;
	conditions = {};	-- a list of lambda functions that represent the conditions of the quest
}

function Quest:new (o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

-- Displays the prompt dialogue line associated to this quest
function Quest:startQuest(npc)
	status_board.dialogue.addDialogue(npc.label, self.prompt)
end

-- Checks whether Gus has completed the quest or not
-- Out: true if completed, false otherwise
function Quest:checkCompletion(npc)
	-- If the quest has already been tagged as resolved, then return true
	if self.resolved then return true end
	
	print ("NPC", npc)
	-- 'ok' will change to False if one of the conditions isn't met
	local ok = true
	-- For each condition of this quest
	for _, func in ipairs(self.conditions) do
		-- we run the function associated to this condition
		if not func() then
			-- if one of the conditions is false, that's over
			ok = false
			break
		end
	end
	-- If ok is still True, it means all the conditions are met
	if ok then
		self.resolved = true
		-- Update Gus memory with the info of the quest completion
		Gus.memory.addInfo("NPCs", {npc.label, "quest_complete", true})
		-- Check the progress of all the quests
		CheckOverallQuestCompletion()
		return true
	else
		return false
	end
end

-- Called when a NPC is created (in main.lua)
-- to assign this NPC this quest
-- In : a npc object
function Quest:assignQuest(npc)
	npc.quest = self
end

-- /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\
-- Beware when you create new conditions:
-- Condition functions should only
-- return binary results (True/False or not-nil/nil)
-- /!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\/!\

-- <<Quest description here>>
quest_meet_everyone = Quest:new{
	prompt = "Personne ne vous connaît ici. Allez vous présenter à tout le monde et nous pourrons peut-être nous entendre.",
	conditions = {	function ()	-- you can use anonymous functions in the conditions
						for _, npc in ipairs(NPC_group) do
							if not Gus.memory.npcs[npc.label] then
								return false
							end
						end
						return true
					end,
				}
}

--<<Quest description here>>
quest_get_tired = Quest:new{
	prompt = "T'es grooooooooooooos, maigri espéce de baleine !.",
	conditions = {	function ()
	
			
						if Gus.vigor < 70 then
							return false
						else
						
							return true
							
						end
					end,
				}
}

--Quete pour courir et faire du sport
quest_do_sports = Quest:new{
	prompt = "Euh, je suis trés gené de te dire ça, mais la femme dont t'es amoureux n'aime pas la graisse, va courir un peu !",
	conditions = {	function ()
	
			local _, Steps = Gus.memory.retrieveInfo(Gus.memory.environement, "step_taken")
						if Steps < 500000 then
							return false
						else
							return true
							
						end
					end,
				}
}


--quete pour frapper le mur
quest_get_hurt = Quest :new {

		prompt = "Montre moi que t'es fort ! , va cogner le mur plus de 500 fois et peut etre que je te repondrais ",
	
		conditions = {	function ()
	
						local _, Hits = Gus.memory.retrieveInfo(Gus.memory.environement, "wall_hit")
			
						if Hits < 500 then
							return false
						else
							return true
							
						end
					end,
				}

}

-- quete pour trouver un PNJ en particulier
quest_find_him = Quest :new {

		prompt = "Trouve le petit ami de la femme de ta vie!, c'est un pirate askip..",
	
		conditions = {	function ()
		
						
						if Gus.memory.npcs["Tarek"] then 
							return true
						else
							return false
						end
					end,
				}

}


quest_get_tired = Quest:new{
	prompt = "Tu es trop vif pour moi, reviens quand tu seras calmé.",
	conditions = {	function ()
	
			
						if Gus.vigor < 70 then
							return false
						else
							return true
							
						end
					end,
				}
 }

----------------------------------
-- Overall quest progress
----------------------------------

-- list all the quests that have to be resolved to meet the objective of the simulation
-- (if the objective consists in completing all the quests)
--QUEST_GROUP = {quest_meet_everyone, quest_get_tired, quest_get_hurt, quest_find_him,quest_do_sports}
QUEST_GROUP = {quest_find_him,quest_do_sports,quest_get_hurt}
--QUEST_GROUP = {quest_meet_everyone,quest_get_tired}

--this function is called every time Gus completes a quest
function CheckOverallQuestCompletion()
	for _, quest in ipairs(QUEST_GROUP) do
		if not quest.resolved then
			if Gus.money < 95 then 
			Gus.money = Gus.money+5 --Gus gagne 5 euros s'il réussit la quete et si sont argent est inférieur à 95
			end
			return false
			
		end
	
	end
	-- Gus' reward
	Gus.money = Gus.money + 5 -- Gus gagne 5 euros s'il réussit tout les quetes
	Gus.imgfile = "assets/img/Gus_Crown.png"
	Gus.img = love.graphics.newImage(Gus.imgfile)
	Gus.quests_ok=true     -- boolean pour dire que toutes les quetes on était validée
	return true
end

