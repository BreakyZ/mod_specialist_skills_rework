::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/sellsword_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost = 130;
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistBodyguardTree]
	}
});
