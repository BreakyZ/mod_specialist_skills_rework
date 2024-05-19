::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_militia_damage", function ( q )
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
			_properties.DamageRegularMin += actor.calculateSpecialistMultiplier(0.04, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistMultiplier(0.107, specialistWeapon);
		}
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			_properties.DamageRegularMin += actor.calculateSpecialistMultiplier(0.04, false);
			_properties.DamageRegularMax += actor.calculateSpecialistMultiplier(0.107, false);
		}
	}
});
