::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/nomad_sling", function( q )
{	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 800;
		this.m.RangeMin = 2;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.7;
		this.m.StaminaModifier = -10;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.WeaponType = this.Const.Items.WeaponType.Sling | this.Const.Items.WeaponType.Staff;
		this.m.AdditionalAccuracy = -10;
	}

	q.onEquip = @( __original ) function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_sling_heavy_stone_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_slingstaff_bash"));
	}
});