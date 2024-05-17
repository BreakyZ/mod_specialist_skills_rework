::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_hammer_damage", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isItemType(this.Const.Items.ItemType.OneHanded) && item.isWeaponType(this.Const.Items.WeaponType.Hammer))
		{

			if (item.getID() == "weapon.legend_hammer" || item.getID() == "weapon.legend_named_blacksmith_hammer")
			{
				specialistWeapon = true
			}
			_properties.DamageRegularMin += actor.calculateSpecialistMultiplier(0.04, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistMultiplier(0.107, specialistWeapon);
		}
	}
});
