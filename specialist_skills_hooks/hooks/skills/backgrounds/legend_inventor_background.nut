::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistInventorTree, this.Const.Perks.RepairClassTree]
	}
});
