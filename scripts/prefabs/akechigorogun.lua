local assets =
{
	Asset("ANIM", "anim/akechigorogun.zip"),
    Asset("ANIM", "anim/swap_akechigorogun.zip"),
}
prefabs = {
}

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_akechigorogun", "swap_akechigorogun")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function OnFinished(inst)
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange()

    inst:AddTag("outofammo")

    local owner = inst.components.inventoryitem.owner

    if owner ~= nil then
        owner.components.talker:Say("Out of ammo...")
    end
end

local function OnAttack(inst)
    if inst:HasTag("outofammo") then
        inst.components.finiteuses:SetUses(1) -- To prevent minus percentage
    end
end

local function init()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("akechigorogun")
    inst.AnimState:SetBuild("akechigorogun")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("akechigorogun.tex")

    MakeInventoryPhysics(inst)
    
    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.AKECHIGOROGUN_DAMAGE)
    inst.components.weapon:SetRange(TUNING.AKECHIGOROGUN_RANGE)
    inst.components.weapon:SetOnAttack(OnAttack)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/akechigorogun.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
   
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(8)
    inst.components.finiteuses:SetUses(8)
    inst.components.finiteuses:SetOnFinished(OnFinished)

    --TheInput:AddKeyUpHandler(
    --    TUNING.AKECHIGORO_RELOADKEY,
    --    function ()
    --        Reload(inst)
    --    end)

    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.NAMES.AKECHIGOROGUN = "SIG-Sauer P230"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.AKECHIGOROGUN = "Suppressed, ready to silently kill"

return  Prefab("common/inventory/akechigorogun", init, assets, prefabs)