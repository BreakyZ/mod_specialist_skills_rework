::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/daytaler_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		local classTrees = 
		[
			this.Const.Perks.PitchforkClassTree,
			this.Const.Perks.SickleClassTree,
			this.Const.Perks.WoodaxeClassTree,
			this.Const.Perks.HammerClassTree,
			this.Const.Perks.ShovelClassTree,
			this.Const.Perks.PickaxeClassTree,
			this.Const.Perks.ButcherClassTree
		];
		local weaponTrees =
		[
			this.Const.Perks.PolearmTree,
			this.Const.Perks.SwordTree,
			this.Const.Perks.AxeTree,
			this.Const.Perks.HammerTree,
			this.Const.Perks.MaceTree,
			this.Const.Perks.HammerTree,
			this.Const.Perks.CleaverTree,

		];
		local rand = this.Math.rand(0, 13);
		if (rand <= 6)
		{
			this.m.PerkTreeDynamic.Class.push(classTrees[rand]);
			this.m.PerkTreeDynamic.Weapon.push(weaponTrees[rand]);
		}
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/daytaler_southern_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		local classTrees = 
		[
			this.Const.Perks.PitchforkClassTree,
			this.Const.Perks.SickleClassTree,
			this.Const.Perks.WoodaxeClassTree,
			this.Const.Perks.HammerClassTree,
			this.Const.Perks.ShovelClassTree,
			this.Const.Perks.PickaxeClassTree,
			this.Const.Perks.ButcherClassTree
		];
		local weaponTrees =
		[
			this.Const.Perks.PolearmTree,
			this.Const.Perks.SwordTree,
			this.Const.Perks.AxeTree,
			this.Const.Perks.HammerTree,
			this.Const.Perks.MaceTree,
			this.Const.Perks.HammerTree,
			this.Const.Perks.CleaverTree,

		];
		local rand = this.Math.rand(0, 13);
		if (rand <= 6)
		{
			this.m.PerkTreeDynamic.Class.push(classTrees[rand]);
			this.m.PerkTreeDynamic.Weapon.push(weaponTrees[rand]);
		}
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistInventorTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_commander_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[0].push(this.Const.Perks.PerkDefs.SpecialistInventor);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/retired_soldier_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 30;

		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistBodyguardTree);
		this.m.PerkTreeDynamic.Weapon.push(this.Const.Perks.GreatSwordTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/sellsword_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 30;
		local classTrees = 
		[
			this.Const.Perks.SpecialistBodyguardTree,
			this.Const.Perks.SpecialistClubTree
		];
		local weaponTrees =
		[
			this.Const.Perks.GreatSwordTree,
			this.Const.Perks.MaceTree

		];
		local rand = this.Math.rand(0, 1)
		this.m.PerkTreeDynamic.Class.push(classTrees[rand]);
		this.m.PerkTreeDynamic.Weapon.push(weaponTrees[rand]);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/witchhunter_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 10;
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistInquisitionTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_youngblood_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 5;
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistInquisitionTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/wildman_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 5;
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistClubTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/wildwoman_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 5;
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistClubTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/vagabond_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 5;
		this.m.PerkTreeDynamic.Weapon.push(this.Const.Perks.MaceTree)
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistClubTree);
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/caravan_hand_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost += 10;
		this.m.PerkTreeDynamic.Weapon.push(this.Const.Perks.MaceTree);
		this.m.PerkTreeDynamic.Class.push(this.Const.Perks.SpecialistClubTree);
	}
});
