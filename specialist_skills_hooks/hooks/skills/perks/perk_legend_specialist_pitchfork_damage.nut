::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_pitchfork_damage", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && (item.isItemType(this.Const.Items.ItemType.Pitchfork) || item.isWeaponType(this.Const.Items.WeaponType.Polearm)))
		{

			if (item.isItemType(this.Const.Items.ItemType.Pitchfork))
			{
				specialistWeapon = true
			}
			_properties.DamageRegularMin += actor.calculateSpecialistMultiplier(0.04, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistMultiplier(0.107, specialistWeapon);
		}
	}
});
