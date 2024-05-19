::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_ninetails_damage", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && (item.isItemType(this.Const.Items.ItemType.Cultist) || item.getID() == "weapon.orc_flail_2h" || item.getID() == 'named_orc_flail_2h'))
		{

			if (item.getID() == "weapon.legend_cat_o_nine_tails")
			{
				specialistWeapon = true
			}
			_properties.DamageRegularMin += actor.calculateSpecialistMultiplier(0.04, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistMultiplier(0.107, specialistWeapon);
		}
		if (item != null && item.getID() == "weapon.three_headed_flail")
		{
			_properties.DamageRegularMin += actor.calculateSpecialistMultiplier(0.04, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistMultiplier(0.107, specialistWeapon);
		}
	}
});