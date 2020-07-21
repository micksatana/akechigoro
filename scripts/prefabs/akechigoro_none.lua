local assets =
{
	Asset( "ANIM", "anim/akechigoro.zip" ),
	Asset( "ANIM", "anim/ghost_akechigoro_build.zip" ),
}

local skins =
{
	normal_skin = "akechigoro",
	ghost_skin = "ghost_akechigoro_build",
}

return CreatePrefabSkin("akechigoro_none",
{
	base_prefab = "akechigoro",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"AKECHIGORO", "CHARACTER", "BASE"},
	build_name_override = "akechigoro",
	rarity = "Character",
})