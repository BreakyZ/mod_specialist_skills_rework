::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/daytaler_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.PitchforkClassTree]
	}
});
