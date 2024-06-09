::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/retired_soldier_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost = 150;
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistBodyguardTree]
	}
});
