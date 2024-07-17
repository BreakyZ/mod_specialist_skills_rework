::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_woodaxe_skill", function ( q )
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Axe) && !item.getID() == "weapon.legend_saw":
				return;
			case item.getID() == "weapon.woodcutters_axe" || item.getID() == "weapon.legend_saw":
				specialistWeapon = true;
		}

		if (item.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}
		else
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}

		if (actor.getCurrentProperties().IsSpecializedInAxes)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.validTarget <- function( _targetID)
	{
		if (_targetID == this.Const.EntityType.Schrat)
		{
			return true;
		}
		return false;
	}

	q.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		if (item == null || (!item.isWeaponType(this.Const.Items.WeaponType.Axe) && !item.getID() == "weapon.legend_saw"))
		{
			return;
		}

		if (item.getID() == "weapon.woodcutters_axe" || item.getID() == "weapon.legend_saw")
		{
			specialistWeapon = true;
		}
		
		if (this.validTarget(_targetEntity.getType()))
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

			if (actor.getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
			}
		}
		else
		{
			return;
		}
	}
});
