local slings = [
	"legend_sling"
];
foreach (sling in slings)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/" + sling, function( q )
	{	
		q.create = @(__original) function()
		{
			__original();

			this.m.RangeMax = 6;
			this.m.RangeIdeal = 6;
		}
	});
}

local slingstaves = [
	"legend_slingstaff"
];
if (::Is_SSU_Exist)
	slingstaves.push("named/named_northern_sling");

foreach (sling in slingstaves)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/" + sling, function( q )
	{	
		q.onEquip = @( __original ) function()
		{
			this.weapon.onEquip();
			this.addSkill(this.new("scripts/skills/actives/legend_sling_heavy_stone_skill"));
			this.addSkill(this.new("scripts/skills/actives/legend_slingstaff_bash_skill"));
			
			this.addSkill(this.new("scripts/skills/actives/launch_acid_flask"));
			this.addSkill(this.new("scripts/skills/actives/launch_daze_bomb_skill"));
			this.addSkill(this.new("scripts/skills/actives/launch_fire_bomb_skill"));
			this.addSkill(this.new("scripts/skills/actives/launch_holy_water"));
			this.addSkill(this.new("scripts/skills/actives/launch_smoke_bomb_skill"));
			if (::Is_SSU_Exist)
				this.addSkill(this.new("scripts/skills/actives/launch_acid_flask_02"));
		}
	});
}

local slings = [
	"oriental/nomad_sling"
];
if (::Is_SSU_Exist)
	slings.push("named/named_sling");
foreach (sling in slings)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/oriental/nomad_sling", function( q )
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
		}

		q.onEquip = @( __original ) function()
		{
			this.weapon.onEquip();
			this.addSkill(this.new("scripts/skills/actives/legend_sling_heavy_stone_skill"));
			this.addSkill(this.new("scripts/skills/actives/legend_slingstaff_bash"));
			
			this.addSkill(this.new("scripts/skills/actives/launch_acid_flask"));
			this.addSkill(this.new("scripts/skills/actives/launch_daze_bomb_skill"));
			this.addSkill(this.new("scripts/skills/actives/launch_fire_bomb_skill"));
			this.addSkill(this.new("scripts/skills/actives/launch_holy_water"));
			this.addSkill(this.new("scripts/skills/actives/launch_smoke_bomb_skill"));
			if (::Is_SSU_Exist)
				this.addSkill(this.new("scripts/skills/actives/launch_acid_flask_02"));
		}
	});
}

