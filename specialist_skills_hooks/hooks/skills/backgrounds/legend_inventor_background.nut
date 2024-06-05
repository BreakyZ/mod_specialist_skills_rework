::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/backgrounds/legend_inventor_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.OrganisedTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.SpecialistInventorTree
				this.Const.Perks.RepairClassTree
			],
			Magic = [
				this.Const.Perks.PhilosophyMagicTree,
				this.Const.Perks.InventorMagicTree
			]
		}
	}
});
