::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/daytaler_souther_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.LegendSpecialistPitchforkSkill]
	}
});
