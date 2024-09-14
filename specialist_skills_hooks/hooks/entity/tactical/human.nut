::ModSpecialistSkillsRework.HooksMod.hookTree("scripts/entity/tactical/human", function( q ) 
{
	q.onInit = @(__original) function()
	{
		__original();
		local damagePerks = [
			"legend_specialist_butcher_damage",
			"legend_specialist_militia_damage",
			"legend_specialist_shortbow_damage",
			"legend_specialist_shovel_damage",
			"legend_specialist_sickle_damage",
			"legend_specialist_sling_damage",
			"legend_specialist_pitchfork_damage",
			"legend_specialist_ninetails_damage",
			"legend_specialist_lute_damage",
			"legend_specialist_knife_damage",
			"legend_specialist_hammer_damage",
			"legend_specialist_pickaxe_damage",
			"legend_specialist_scythe_damage"]
		foreach (perk in damagePerks)
		{
			this.m.Skills.removeByID("perk.perk_" + perk)
		}
	}
});