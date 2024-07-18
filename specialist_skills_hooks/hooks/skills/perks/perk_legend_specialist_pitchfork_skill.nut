::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_pitchfork_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
				return;
			case !(item.isWeaponType(this.Const.Items.WeaponType.Polearm) || item.isItemType(this.Const.Items.ItemType.Pitchfork)):
				return;
			case item.isItemType(this.Const.Items.ItemType.Pitchfork):
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageArmorMult += actor.calculateSpecialistBonus(0.25, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInPolearms)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(9, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(24, specialistWeapon);
		}
	}
});
