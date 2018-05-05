----------------------------------
-- CONSTANTS
-- Constants for everything
-- (Gus, the room, the NPCs...)
----------------------------------
GUS_PATIENCE_MIN = 0
GUS_PATIENCE_MAX = 100
GUS_PATIENCE_TIMER_MIN = 0	-- in seconds
GUS_PATIENCE_TIMER_MAX = 30	-- in seconds
GUS_PATIENCE_LABEL = "patience"


-- Gus: Some initial and default values
GUS_INITIAL_POSITION_X = 510
GUS_INITIAL_POSITION_Y = 530
GUS_STEP_SIZE_MAX = 200
GUS_STEP_SIZE_MIN = 0
GUS_DESIRE_TO_TURN_MAX = 10
GUS_HIT = 1

GUS_VIGOR_STEP = 0.01	-- The added/substracted value for each change in Gus' vigor. Change it to tune the speed at which Gus'll gain/lose vigor.
GUS_VIGOR_MIN = 0		-- The minimum value of Vigor
GUS_VIGOR_MAX = 100		-- The maximum value of Vigor
GUS_VIGOR_LABEL = "vigor"

GUS_SOCIABILITY_STEP = 5	-- The added/substracted value for each change in Gus' sociability. Change it to tune the impact of each interaction on Gus' sociability.
GUS_SOCIABILITY_MIN = 0		-- The minimum value of Sociability
GUS_SOCIABILITY_MAX = 100	-- The maximum value of Sociability
GUS_SOCIABILITY_LABEL = "sociability"

GUS_MONEY_STEP = 0.1	-- The added/substracted value for each change in Gus Money
GUS_MONEY_MIN = 0		-- The minimum value of Money
GUS_MONEY_MAX = 100		-- The maximum value of money
GUS_MONEY_LABEL = "money"

--Directions for Gus' moving
DIRECTION_UP = "up"
DIRECTION_DOWN = "down"
DIRECTION_LEFT = "left"
DIRECTION_RIGHT = "right"

-- Keyboard shortcuts
-- You can find the list of key strings here: https://love2d.org/wiki/KeyConstant
SHORTCUT_QUIT = {"escape"}
SHORTCUT_TOGGLEMOVINGMODE = {"return", "kpenter"}	-- kpenter is the numpad enter key
SHORTCUT_MOVEUP = {"z", "up"}
SHORTCUT_MOVEDOWN = {"s", "down"}
SHORTCUT_MOVELEFT = {"q", "left"}
SHORTCUT_MOVERIGHT = {"d", "right"}
SHORTCUT_STOPINTERACTION = {"e"}

-- Gauge settings. Used to finely position the gauges on the window
GAUGE_BORDER_SIZE = 3	
GAUGE_WIDTH = 22
GAUGE_HEIGHT_MIN = 0
GAUGE_HEIGHT_MAX = 72
GAUGE_CONTAINER_WIDTH = 28
GAUGE_CONTAINER_HEIGHT = 75

-- Room's dimensions
ROOM_INNER_WIDTH = 553
ROOM_INNER_HEIGHT = 589
ROOM_OFFSET = 4

-- NPC
NPC_LABEL = "NPC"
NPC_PROFILE_ARROGANT = "arrogant"
NPC_PROFILE_CHARMER = "charmer"
NPC_PROFILE_AGGRESSIVE = "aggressive"
NPC_PROFILE_SHY = "shy"

NPC_NAMES = {"Madder", "Britney", "Tarek", "Jean"}
-- The NPC should be listed in the same order as NPC_NAMES
NPC_LIST = {
	[1] = {
		imgfile = "NPC1.png",
		profile = NPC_PROFILE_ARROGANT,
		x = 50,
		y = 50,
	},
	[2] = {
		imgfile = "NPC2.png",
		profile = NPC_PROFILE_CHARMER,
		x = 400,
		y = 150,
	},
	[3] = {
		imgfile = "NPC3.png",
		profile = NPC_PROFILE_AGGRESSIVE,
		x = 100,
		y = 400,
	},
	[4] = {
		imgfile = "NPC4.png",
		profile = NPC_PROFILE_SHY,
		x = 300,
		y = 350,
	},
}
NPC_LEXICON = {
	[NPC_PROFILE_CHARMER] = {"ravissante",
	},
	[NPC_PROFILE_SHY] = {"Euh",
	},
	[NPC_PROFILE_AGGRESSIVE] = {"ferme",
	},
	[NPC_PROFILE_ARROGANT] = {"nique",
	},
}

dico = {'aujourd', 'hui', 'aujourd hui'}
-- Status board
STATUS_BOARD_REGULAR_MODE = "regular"
STATUS_BOARD_ALERT_MODE = "alert"
STATUS_BOARD_REGULAR_COLOR = {0, 0, 0, 255}
STATUS_BOARD_ALERT_COLOR = {255, 0, 0}

-- Dialogue
DIALOGUE_TIMER_MIN = 0
DIALOGUE_TIMER_MAX = 100
DIALOGUE_INIT = "INIT"
DIALOGUE_NEXT = "NEXT"
DIALOGUE_STOP = "STOP"

-- Miscellaneous
DEBUG_MODE = true