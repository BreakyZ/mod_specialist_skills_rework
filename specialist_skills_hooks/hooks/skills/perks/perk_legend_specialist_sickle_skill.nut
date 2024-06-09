::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_sickle_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
				return;
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return;
			case item.getID() == "weapon.sickle" || item.getID() == "weapon.goblin_notched_blade"  || item.getID() == "weapon.legend_named_sickle":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageDirectMult += 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInSwords)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
