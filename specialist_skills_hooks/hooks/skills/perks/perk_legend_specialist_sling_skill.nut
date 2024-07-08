::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_sling_skill", function ( q )
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Sling):
				return;
			case item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingshot":
				specialistWeapon = true;
		}

		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (item.getID() == "weapon.legend_slingstaff" || item.getID() == "weapon.named_northern_sling")
		{
			_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(50, specialistWeapon);
		}
		else
		{
			_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon)
		}

		if (actor.getCurrentProperties().IsSpecializedInSlings)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);

			if (item.getID() == "weapon.legend_slingstaff" || item.getID() == "weapon.named_northern_sling")
			{
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(15, specialistWeapon);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(30, specialistWeapon);
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{	
		local actor = this.getContainer().getActor();
		if (_skill.getID() == "actives.legend_slingstaff_bash" && actor.getCurrentProperties().IsSpecializedInSlings)
		{
			_properties.DamageRegularMin -= 6;
			_properties.DamageRegularMax -= 16;
		}
	}
});
