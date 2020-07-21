local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local startingItems = {
	akechigorogun = {atlas = "images/inventoryimages/akechigorogun.xml"},
}

-- Your character's stats
TUNING.AKECHIGORO_HEALTH = 200
TUNING.AKECHIGORO_HUNGER = 200
TUNING.AKECHIGORO_SANITY = 100

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.AKECHIGORO = {
	"akechigorogun",
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE = type(TUNING.STARTING_ITEM_IMAGE_OVERRIDE) == "table" and MergeMaps(TUNING.STARTING_ITEM_IMAGE_OVERRIDE, startingItems) or startingItems

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.AKECHIGORO
end
local prefabs = FlattenTree(start_inv, true)

local function TrustNoOne(inst)
	if inst:HasTag("playerghost") then
		return
	end

	local x,y,z = inst.Transform:GetWorldPosition()
	local players = FindPlayersInRange(x, y, z, 3, true)
	local delta = 0

	for k,player in pairs(players) do
		if player.prefab ~= "akechigoro" then
			delta = delta - 1
		end
	end

	if delta < 0 then
		inst.components.sanity:DoDelta(delta)
	end
end

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "akechigoro_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "akechigoro_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
	inst:ListenForEvent("ms_becameghost", onbecameghost)
	inst:ListenForEvent("killed", function(inst, data)
		if data.victim ~= nil then
			inst.components.sanity:DoDelta(8)
		end
	end)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon("akechigoro.tex")
    inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("akechigoro", TUNING.AKECHIGORO_RELOADKEY, "RELOAD")
    inst:AddComponent("playerprox")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.AKECHIGORO_HEALTH)
	inst.components.hunger:SetMax(TUNING.AKECHIGORO_HUNGER)
	inst.components.sanity:SetMax(TUNING.AKECHIGORO_SANITY)

	inst.Transform:SetScale(1.3, 1.3, 1.3)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 0.3
	
	inst.OnLoad = onload
	inst.OnNewSpawn = onload
	
	inst:DoPeriodicTask(2, TrustNoOne, 2)
end

local function Reload(inst)
	local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

	if weapon == nil or weapon.prefab ~= 'akechigorogun' then
		return
	end

    inst.components.talker:Say("Reloading...")
    if inst.components.playercontroller ~= nil then
		inst.components.playercontroller:Enable(false)
	end

	inst.components.locomotor:Stop()
	inst.components.locomotor:Clear()
    inst:ClearBufferedAction()

    -- TODO: custom animation

    inst:DoTaskInTime(
        1,
        function()
            weapon.components.weapon:SetDamage(TUNING.AKECHIGOROGUN_DAMAGE)
            weapon.components.weapon:SetRange(TUNING.AKECHIGOROGUN_RANGE)
            weapon.components.finiteuses:SetUses(8)
            weapon:RemoveTag("outofammo")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end)
end

AddModRPCHandler("akechigoro", "RELOAD", Reload)

return MakePlayerCharacter("akechigoro", prefabs, assets, common_postinit, master_postinit, prefabs)
