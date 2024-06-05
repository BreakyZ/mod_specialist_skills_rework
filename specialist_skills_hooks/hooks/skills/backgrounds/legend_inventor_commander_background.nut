::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_commander_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[0].push(this.Const.Perks.PerkDefs.SpecialistInventor)
	}
});
