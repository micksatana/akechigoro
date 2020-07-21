PrefabFiles = {
	"akechigoro",
	"akechigoro_none",
	"akechigorogun",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/akechigoro.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/akechigoro.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/akechigoro.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/akechigoro.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/akechigoro_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/akechigoro_silho.xml" ),

    Asset( "IMAGE", "bigportraits/akechigoro.tex" ),
    Asset( "ATLAS", "bigportraits/akechigoro.xml" ),
	
	Asset( "IMAGE", "images/map_icons/akechigoro.tex" ),
	Asset( "ATLAS", "images/map_icons/akechigoro.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_akechigoro.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_akechigoro.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_akechigoro.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_akechigoro.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_akechigoro.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_akechigoro.xml" ),
	
	Asset( "IMAGE", "images/names_akechigoro.tex" ),
    Asset( "ATLAS", "images/names_akechigoro.xml" ),
	
	Asset( "IMAGE", "images/names_gold_akechigoro.tex" ),
    Asset( "ATLAS", "images/names_gold_akechigoro.xml" ),

    Asset("IMAGE", "images/inventoryimages/akechigorogun.tex"),
    Asset("ATLAS", "images/inventoryimages/akechigorogun.xml"),
}

AddMinimapAtlas("images/map_icons/akechigoro.xml")
AddMinimapAtlas("images/map_icons/akechigorogun.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING

-- The character select screen lines
STRINGS.CHARACTER_TITLES.akechigoro = "Akechi Goro"
STRINGS.CHARACTER_NAMES.akechigoro = "Akechi Goro"
STRINGS.CHARACTER_DESCRIPTIONS.akechigoro = "*Has a gun\n*Killer instinct\n*Perk 3"
STRINGS.CHARACTER_QUOTES.akechigoro = "\"Quote\""
STRINGS.CHARACTER_SURVIVABILITY.akechigoro = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.AKECHIGORO = require "speech_akechigoro"

-- The character's name as appears in-game 
STRINGS.NAMES.AKECHIGORO = "Akechi"
STRINGS.SKIN_NAMES.akechigoro_none = "Akechi"

TUNING.AKECHIGORO_RELOADKEY = GetModConfigData("reloadkey") or 114
TUNING.AKECHIGOROGUN_DAMAGE = 100
TUNING.AKECHIGOROGUN_RANGE = 10

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("akechigoro", "MALE", skin_modes)
