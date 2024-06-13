::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/daytaler_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.PitchforkClassTree]
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/daytaler_southern_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.PitchforkClassTree]
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistInventorTree, this.Const.Perks.RepairClassTree]
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_commander_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[0].push(this.Const.Perks.PerkDefs.SpecialistInventor)
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/retired_soldier_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 30;
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistBodyguardTree]
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/sellsword_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 30;
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistBodyguardTree]
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/witchhunter_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 10;
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.SpecialistInquisitionTree, this.Const.Perks.FaithClassTree]
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_youngblood_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 5;
		this.m.PerkTreeDynamic.Class <- [this.Const.Perks.FaithClassTree, this.Const.Perks.ChefClassTree, this.Const.Perks.SpecialistInquisitionTree]
	}
});
