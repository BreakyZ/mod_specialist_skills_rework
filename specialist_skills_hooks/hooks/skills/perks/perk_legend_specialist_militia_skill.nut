::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_militia_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Spear))
		{

			if (item.getID() == "weapon.militia_spear" || item.getID() == "weapon.legend_wooden_spear" || item.getID() == "weapon.ancient_spear")
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.MeleeDefense += actor.calculateSpecialistMultiplier(0.04, specialistWeapon);
		}

		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			_properties.RangedSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
		}
	}
});
